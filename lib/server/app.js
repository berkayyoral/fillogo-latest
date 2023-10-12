const { Console } = require('console');
const express = require('express');
const app = express();
const http = require('http');

const server = http.createServer(app);
const https = require('https');

const { Server } = require("socket.io");
// const io = new Server(server);

const io = require("socket.io")(server, {
  cors: {
    origin: "*",  // sonra değiştirilecek
  },
});


    let activeUsers = [];
    let userInChat = [];
    
    const getUser = (id) => {
      return activeUsers.find((user) => user.userId === id);
    }
    
    const sendNotification = (data) => {
        var headers = {
            "Content-Type": "application/json; charset=utf-8",
            Authorization: "Bearer token=" + "Mzc4ZGIxYmUtNDAyOS00ODFkLWI4ZTAtYjdjNTI1NzBhNDBh"
        };
        var options = {
            host: "onesignal.com",
            port: 443,
            path: "/api/v1/notifications",
            method: "POST",
            headers: headers
        };
    
        var req = https.request(options, function(res) {
            res.on('data', function(data) {
                 log("Response:");
                 log(JSON.parse(data));
            });
        });
    
        req.on('error', function(e) {
           console.log("ERROR:");
             console.log(e);
        });
    
        req.write(JSON.stringify(data));
        req.end();
    }   

    io.on("connection", (socket) => {
        socket.on("new-user-add", (newUserId) => {
          if (!activeUsers.some((user) => user.userId === newUserId)) {
            activeUsers.push({ userId: newUserId, socketId: socket.id });
             console.log("New User Connected", activeUsers);
         //   updateMessageStatus(newUserId, "delivered");
          }
          io.emit("get-users", activeUsers);
        });
      
        socket.on("add-chat-user", ({chatId, userId}) => {
          if (!userInChat.some((user) => user.userId === userId)) {
            userInChat.push({ userId , chatId});
            //  console.log("In the chat  -> ", userInChat);
          }
          console.log("In the chat users", userInChat);

          const usersInCurrentChat = userInChat.filter((user) => user.chatId === chatId);
          io.emit("get-users-in-chat", usersInCurrentChat);
        
        
        });

        socket.on("remove-chat-user", ({userId}) => {
          userInChat = userInChat.filter((user) => user.userId !== userId);
          const chatIds = [...new Set(userInChat.map((user) => user.chatId))];
          const usersInCurrentChat = chatIds.map((chatId) => {
            return {
              chatId,
              users: userInChat.filter((user) => user.chatId === chatId),
            };
          });
          console.log("In the chat users", userInChat);

          io.emit("get-users-in-chat", usersInCurrentChat);
        });
      
    
        socket.on("disconnect", () => {
          activeUsers = activeUsers.filter((user) => user.socketId !== socket.id);
          console.log("User Disconnected", activeUsers);
          io.emit("get-users", activeUsers);
        });
      
        socket.on("offline", () => {
          activeUsers = activeUsers.filter((user) => user.socketId !== socket.id);
          console.log("User Disconnected", activeUsers);
          io.emit("get-users", activeUsers);
        });
      
        socket.on("notification", ({sender, receiver, type, message,params}) => {
          const user = getUser(receiver);
          if(user) {
          //  console.log(user);
            io.to(user.socketId).emit("get-notification", { 
              message,
              sender,
              receiver,
              type,
              params,
            });
          } else {
              console.log("user not online");
      
              const offlineNotification = {
                  contents: {en: `${message.text.username} ${message.text.content}`},
                  include_external_user_ids:[ `${receiver}`],  // receiver's id (from user table)
                  app_id: "43ddc771-f2eb-4ecf-bcc8-95434809b1dc",
                  data:{
                    "type": type, 
                    "param": params,
                    "sender": sender, 
                    "receiver": receiver, 
                    
                },

              };
      
              sendNotification(offlineNotification);
          }
    
          // saveNotification({receiver, message, type});
      });

      socket.on("notification-to-all", ({type, notification}) => {
        const offlineNotification = {
          contents: {en: `${notification.text.content}`},
          app_id: "43ddc771-f2eb-4ecf-bcc8-95434809b1dc",
        };
        sendNotification(offlineNotification);
      });
      
      socket.on("typing", (receiverId) => {
        const user = getUser(receiverId);
        if (user) {
          io.to(user.socketId).emit("receiver-typing", receiverId);
        }
      });

      socket.on("send-message", function(data){
        console.log(data);
        socket.emit("recieve-message", data);
    });
    

      socket.on("message-seen-status", (data) => {
         console.log("-------SEEN-------")
        data.status = "seen";
        // updateMessageStatus(data.chatId, data.status);
       console.log("Message seen by: ", data)
        io.emit("message-seen", data);
      })

      socket.on('file-meta', (data) => {
        const { receiverId } = data;
        const user = activeUsers.find((user) => user.userId === receiverId);
         console.log("Sending from socket to :", receiverId)
         console.log("Data: ", data)
        if (user) {
          io.to(user.socketId).emit("fs-meta", data.metadata);
        }
      })

      socket.on('fs-start', (data) => {
        const { receiverId } = data;
        const user = activeUsers.find((user) => user.userId === receiverId);
         console.log("Sending from socket to :", receiverId)
         console.log("Data: ", data)
        if (user) {
          io.to(user.socketId).emit("fs-share", {});
        }
      })

      socket.on('file-raw', (data) => {
        const { receiverId } = data;
        const user = activeUsers.find((user) => user.userId === receiverId);
         console.log("Sending from socket to :", receiverId)
         console.log("Data: ", data)
        if (user) {
          io.to(user.socketId).emit("fs-share", data.buffer);
        }
      })

    });

    server.listen(5000, () => {
         console.log('listening on *:5000');
    });
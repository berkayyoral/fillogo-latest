class SearchUserResponse {
  int? success;
  List<Data>? data;
  String? message;

  SearchUserResponse({this.success, this.data, this.message});

  SearchUserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  SearchResult? searchResult;

  Data({this.searchResult});

  Data.fromJson(Map<String, dynamic> json) {
    searchResult = json['searchResult'] != null
        ? SearchResult.fromJson(json['searchResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (searchResult != null) {
      data['searchResult'] = searchResult!.toJson();
    }
    return data;
  }
}

class SearchResult {
  List<UserResult>? result;
  Pagination? pagination;

  SearchResult({this.result, this.pagination});

  SearchResult.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <UserResult>[];
      json['result'].forEach((v) {
        result!.add(UserResult.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class UserResult {
  int? id;
  String? name;
  String? surname;
  String? username;
  String? profilePicture;
  String? title;
  bool? amIfollowing;
  int? routeCount;

  UserResult(
      {this.id,
      this.name,
      this.surname,
      this.username,
      this.profilePicture,
      this.title,
      this.amIfollowing,
      this.routeCount});

  UserResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    username = json['username'];
    profilePicture = json['profilePicture'];
    title = json['title'];
    amIfollowing = json['amIfollowing'];
    routeCount = json['routeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['username'] = username;
    data['profilePicture'] = profilePicture;
    data['title'] = title;
    data['amIfollowing'] = amIfollowing;
    data['routeCount'] = routeCount;
    return data;
  }
}

class Pagination {
  int? totalRecords;
  int? totalPerpage;
  int? totalPage;
  int? currentPage;
  int? nextPage;
  int? previousPage;

  Pagination(
      {this.totalRecords,
      this.totalPerpage,
      this.totalPage,
      this.currentPage,
      this.nextPage,
      this.previousPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalRecords = json['total_records'];
    totalPerpage = json['total_perpage'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    nextPage = json['next_page'];
    previousPage = json['previous_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_records'] = totalRecords;
    data['total_perpage'] = totalPerpage;
    data['total_page'] = totalPage;
    data['current_page'] = currentPage;
    data['next_page'] = nextPage;
    data['previous_page'] = previousPage;
    return data;
  }
}

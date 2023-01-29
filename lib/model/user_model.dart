class UserModel {
  String? uid;
  String? email;
  String? fullName;
  String? password;
  String? releaseTitle;
  String? releaseLabel;
  String? title;
  String? copyrightHolder;
  String? upc;
  String? genre;
  String? primaryArtist;
  String? trackTitle;
  String? parentalAdvistory;
  String? isrc;
  String? role;
  String? writer;
  String? imageReference;
  String? audioReference;
  String? lyrics;
  String? payment;
  String? type;
  String? pending;
  String? earning;
  String? facebookVideo;
  String? amazon;
  String? spotify;
  String? youtube;
  String? appleMusic;
  String? message;
  String? expiryDate;
  String? views;
  String? adminName, adminPassword;
  String? jan,
      feb,
      mar,
      april,
      may,
      june,
      jul,
      aug,
      sep,
      oct,
      nov,
      dec,
      country1,
      country2,
      country3,
      country4,
      country5,
      country1Name,
      country2Name,
      country3Name,
      country4Name,
      country5Name,
      male,
      female,
      royalties,
      royalties1,
      balancePayment,
      balancePayment1,
      paypalClientId;
  String? jan1,
      feb1,
      mar1,
      april1,
      may1,
      june1,
      jul1,
      aug1,
      sep1,
      oct1,
      nov1,
      dec1,
      currentPage,
      task,
      period,
      smartLink,
      collaboratorArtist,
      collaboratorEmail1,
      collaboratorEmail2,
      revenueShareArtist,
      revenueShareEmail1,
      revenueShareEmail2,
      releasePlan,
      date;

  UserModel(
      {this.uid,
      this.email,
      this.fullName,
      this.password,
      this.releaseTitle,
      this.releaseLabel,
      this.audioReference,
      this.trackTitle,
      this.parentalAdvistory,
      this.writer,
      this.role,
      this.isrc,
      this.primaryArtist,
      this.title,
      this.copyrightHolder,
      this.genre,
      this.upc,
      this.imageReference,
      this.lyrics,
      this.payment,
      this.type,
      this.pending,
      this.earning,
      this.spotify,
      this.amazon,
      this.facebookVideo,
      this.youtube,
      this.appleMusic,
      this.message,
      this.expiryDate,
      this.views,
      this.jan,
      this.april,
      this.aug,
      this.dec,
      this.feb,
      this.jul,
      this.june,
      this.mar,
      this.may,
      this.nov,
      this.oct,
      this.sep,
      this.jan1,
      this.april1,
      this.aug1,
      this.dec1,
      this.feb1,
      this.jul1,
      this.june1,
      this.mar1,
      this.may1,
      this.nov1,
      this.oct1,
      this.sep1,
      this.country1,
      this.country2,
      this.country3,
      this.country4,
      this.country5,
      this.country1Name,
      this.country2Name,
      this.country3Name,
      this.country4Name,
      this.country5Name,
      this.male,
      this.female,
      this.balancePayment,
      this.balancePayment1,
      this.royalties,
      this.royalties1,
      this.adminName,
      this.adminPassword,
      this.paypalClientId,
      this.currentPage,
      this.task,
      this.period,
      this.smartLink,
      this.collaboratorArtist,
      this.collaboratorEmail1,
      this.collaboratorEmail2,
      this.revenueShareArtist,
      this.revenueShareEmail1,
      this.revenueShareEmail2,
      this.releasePlan,
      this.date});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      password: map['password'],
      payment: map['payment'],
      type: map['type'],
      pending: map['pending'],
      earning: map['earning'],
      facebookVideo: map['facebookVideo'],
      amazon: map['amazon'],
      spotify: map['spotify'],
      youtube: map['youtube'],
      appleMusic: map['appleMusic'],
      views: map['views'],
      message: map['message'],
      expiryDate: map['expiryDate'],
      jan: map['jan'],
      feb: map['feb'],
      mar: map['mar'],
      april: map['april'],
      may: map['may'],
      june: map['june'],
      jul: map['jul'],
      aug: map['aug'],
      sep: map['sep'],
      oct: map['oct'],
      nov: map['nov'],
      dec: map['dec'],
      jan1: map['jan1'],
      feb1: map['feb1'],
      mar1: map['mar1'],
      april1: map['april1'],
      may1: map['may1'],
      june1: map['june1'],
      jul1: map['jul1'],
      aug1: map['aug1'],
      sep1: map['sep1'],
      oct1: map['oct1'],
      nov1: map['nov1'],
      dec1: map['dec1'],
      country1: map['country1'],
      country2: map['country2'],
      country3: map['country3'],
      country4: map['country4'],
      country5: map['country5'],
      country1Name: map['country1Name'],
      country2Name: map['country2Name'],
      country3Name: map['country3Name'],
      country4Name: map['country4Name'],
      country5Name: map['country5Name'],
      male: map['male'],
      female: map['female'],
      royalties: map['royalties'],
      balancePayment: map['balancePayment'],
      paypalClientId: map['paypalClientId'],
      task: map['task'],
    );
  }
  factory UserModel.fromSongMap(map) {
    return UserModel(
        releaseTitle: map['releaseTitle'],
        releaseLabel: map['releaseLabel'],
        title: map['title'],
        copyrightHolder: map['copyrightHolder'],
        upc: map['upc'],
        genre: map['genre'],
        primaryArtist: map['primaryArtist'],
        trackTitle: map['trackTitle'],
        parentalAdvistory: map['parentalAdvistory'],
        writer: map['writer'],
        role: map['role'],
        isrc: map['isrc'],
        imageReference: map['imageReference'],
        audioReference: map['audioReference'],
        lyrics: map['lyrics'],
        currentPage: map['currentPage'],
        smartLink: map['smartLink'],
        releasePlan: map['releasePlan'],
        date: map['date'],
        collaboratorArtist: map["collaboratorArtist"],
        collaboratorEmail1: map["collaboratorEmail1"],
        collaboratorEmail2: map["collaboratorEmail2"],
        revenueShareArtist: map["revenueShareArtist"],
        revenueShareEmail1: map["revenueShareEmail1"],
        revenueShareEmail2: map["revenueShareEmail2"]);
  }
  factory UserModel.fromMapAdmin(map) {
    return UserModel(
      adminName: map['adminName'],
      adminPassword: map['adminPassword'],
    );
  }
  factory UserModel.fromMapStatement(map) {
    return UserModel(
        period: map['period'],
        balancePayment1: map['balancePayment1'],
        royalties1: map['royalties1']);
  }
  Map<String, dynamic> toMapUpload() {
    return {
      'pending': pending,
      'releaseTitle': releaseTitle,
      'imageReference': imageReference,
      'audioReference': audioReference,
      'primaryArtist': primaryArtist,
      'releaseLabel': releaseLabel,
      'title': title,
      'copyrightHolder': copyrightHolder,
      'genre': genre,
      'trackTitle': trackTitle,
      'parentalAdvistory': parentalAdvistory,
      'writer': writer,
      'role': role,
      'lyrics': lyrics,
      'type': type,
      'upc': upc,
      'isrc': isrc,
      'releasePlan': releasePlan,
      'date': date
    };
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'password': password,
      'earning': earning,
      'facebookVideo': facebookVideo,
      'amazon': amazon,
      'youtube': youtube,
      'appleMusic': appleMusic,
      'spotify': spotify,
      'message': message,
      'payment': payment,
      'expiryDate': expiryDate,
      'country1Name': country1Name,
      'country2Name': country2Name,
      'country3Name': country3Name,
      'country4Name': country4Name,
      'country5Name': country5Name,
      'male': male,
      'female': female,
      'country1': country1,
      'country2': country2,
      'country3': country3,
      'country4': country4,
      'country5': country5,
      'jan': jan,
      'feb': feb,
      'mar': mar,
      'april': april,
      'may': may,
      'june': june,
      'jul': jul,
      'aug': aug,
      'sep': sep,
      'oct': oct,
      'nov': nov,
      'dec': dec,
      'jan1': jan1,
      'feb1': feb1,
      'mar1': mar1,
      'april1': april1,
      'may1': may1,
      'june1': june1,
      'jul1': jul1,
      'aug1': aug1,
      'sep1': sep1,
      'oct1': oct1,
      'nov1': nov1,
      'dec1': dec1,
      'royalties': royalties,
      'balancePayment': balancePayment,
      'paypalClientId': paypalClientId,
      'views': views,
    };
  }

  Map<String, dynamic> toMapAdmin() {
    return {
      'adminName': adminName,
      'adminPassword': adminPassword,
    };
  }

  Map<String, dynamic> toMap1() {
    return {
      'currentPage': "1",
      'releaseTitle': releaseTitle,
      'imageReference': imageReference,
    };
  }

  Map<String, dynamic> toMap2() {
    return {
      'currentPage': "2",
      'audioReference': audioReference,
    };
  }

  Map<String, dynamic> toMap3() {
    return {
      'currentPage': "3",
      'primaryArtist': primaryArtist,
    };
  }

  Map<String, dynamic> toMap4() {
    return {
      'currentPage': "4",
      'releaseLabel': releaseLabel,
      'title': title,
      'copyrightHolder': copyrightHolder,
      'genre': genre,
    };
  }

  Map<String, dynamic> toMap5_1() {
    return {
      'currentPage': "5",
      'copyrightHolder': copyrightHolder,
      'primaryArtist': primaryArtist,
      'trackTitle': trackTitle,
      'parentalAdvistory': parentalAdvistory,
      'writer': writer,
      'role': role,
    };
  }

  Map<String, dynamic> toMap5_1a() {
    return {
      'lyrics': lyrics,
    };
  }

  Map<String, dynamic> toMap6() {
    return {
      'releasePlan': releasePlan,
      'date': date,
    };
  }

  Map<String, dynamic> toMapPayment() {
    return {
      'payment': payment,
      'type': type,
    };
  }

  Map<String, dynamic> toMapMembership() {
    return {
      'payment': payment,
    };
  }

  Map<String, dynamic> toMapUPCISRC() {
    return {
      'upc': upc,
      'isrc': isrc,
    };
  }

  Map<String, dynamic> toMapPendings() {
    return {
      'pending': pending,
    };
  }

  Map<String, dynamic> toMapEarning() {
    return {
      'earning': earning,
    };
  }

  Map<String, dynamic> toMapEarningSocialMedia() {
    return {
      'amazon': amazon,
      'facebookVideo': facebookVideo,
      'spotify': spotify,
      'youtube': youtube,
      'appleMusic': appleMusic,
    };
  }

  Map<String, dynamic> toMapMessage() {
    return {
      'message': message,
    };
  }

  Map<String, dynamic> toMapExpiryDate() {
    return {
      'expiryDate': expiryDate,
    };
  }

  Map<String, dynamic> toMapSmartLink() {
    return {
      'smartLink': smartLink,
    };
  }

  Map<String, dynamic> toMapYoutubeData() {
    return {
      'jan': jan,
      'feb': feb,
      'mar': mar,
      'april': april,
      'may': may,
      'june': june,
      'jul': jul,
      'aug': aug,
      'sep': sep,
      'oct': oct,
      'nov': nov,
      'dec': dec,
    };
  }

  Map<String, dynamic> toMapStreamsAndRoyaltiesData() {
    return {
      'jan1': jan1,
      'feb1': feb1,
      'mar1': mar1,
      'april1': april1,
      'may1': may1,
      'june1': june1,
      'jul1': jul1,
      'aug1': aug1,
      'sep1': sep1,
      'oct1': oct1,
      'nov1': nov1,
      'dec1': dec1,
    };
  }

  Map<String, dynamic> toMapPieData() {
    return {
      'country1': country1,
      'country2': country2,
      'country3': country3,
      'country4': country4,
      'country5': country5,
      'male': male,
      'female': female,
    };
  }

  Map<String, dynamic> toMapPieDataName() {
    return {
      'country1Name': country1Name,
      'country2Name': country2Name,
      'country3Name': country3Name,
      'country4Name': country4Name,
      'country5Name': country5Name,
    };
  }

  Map<String, dynamic> toMapSplitPay() {
    return {
      'collaboratorArtist': collaboratorArtist,
      'collaboratorEmail1': collaboratorEmail1,
      'collaboratorEmail2': collaboratorEmail2,
      'revenueShareArtist': revenueShareArtist,
      'revenueShareEmail1': revenueShareEmail1,
      'revenueShareEmail2': revenueShareEmail2,
    };
  }

  Map<String, dynamic> toMapStatements() {
    return {
      'royalties': royalties,
      'balancePayment': balancePayment,
      'views': views
    };
  }

  Map<String, dynamic> toMapStatements1() {
    return {
      'royalties1': royalties1,
      'balancePayment1': balancePayment1,
      'period': period
    };
  }

  Map<String, dynamic> toMapPaypalClientId() {
    return {
      'paypalClientId': paypalClientId,
    };
  }

  Map<String, dynamic> toMapTask() {
    return {
      'task': task,
    };
  }
}

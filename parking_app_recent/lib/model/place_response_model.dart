// To parse this JSON data, do
//
//     final parkingSpaceData = parkingSpaceDataFromJson(jsonString);

import 'dart:convert';

ParkingSpaceData parkingSpaceDataFromJson(String str) => ParkingSpaceData.fromJson(json.decode(str));

String parkingSpaceDataToJson(ParkingSpaceData data) => json.encode(data.toJson());

class ParkingSpaceData {
    ParkingSpaceData({
        this.htmlAttributions,
        this.results,
        this.status,
    });

    final List<dynamic>? htmlAttributions;
    final List<Result>? results;
    final String? status;

    factory ParkingSpaceData.fromJson(Map<String, dynamic> json) => ParkingSpaceData(
        htmlAttributions: List<dynamic>.from(json["html_attributions"].map((x) => x)),
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "html_attributions": List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "status": status,
    };
}

class Result {
    Result({
        this.businessStatus,
        this.geometry,
        this.icon,
        this.iconBackgroundColor,
        this.iconMaskBaseUri,
        this.name,
        this.openingHours,
        this.placeId,
        this.plusCode,
        this.reference,
        this.scope,
        this.types,
        this.vicinity,
    });

    final String? businessStatus;
    final Geometry? geometry;
    final String? icon;
    final String? iconBackgroundColor;
    final String? iconMaskBaseUri;
    final String? name;
    final OpeningHours? openingHours;
    final String? placeId;
    final PlusCode? plusCode;
    final String? reference;
    final String? scope;
    final List<String>? types;
    final String? vicinity;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        businessStatus: json["business_status"],
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        name: json["name"],
        openingHours: OpeningHours.fromJson(json["opening_hours"]),
        placeId: json["place_id"],
        plusCode: PlusCode.fromJson(json["plus_code"]),
        reference: json["reference"],
        scope: json["scope"],
        types: List<String>.from(json["types"].map((x) => x)),
        vicinity: json["vicinity"],
    );

    Map<String, dynamic> toJson() => {
        "business_status": businessStatus,
        "geometry": geometry!.toJson(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "name": name,
        "opening_hours": openingHours!.toJson(),
        "place_id": placeId,
        "plus_code": plusCode!.toJson(),
        "reference": reference,
        "scope": scope,
        "types": List<dynamic>.from(types!.map((x) => x)),
        "vicinity": vicinity,
    };
}

class Geometry {
    Geometry({
        this.location,
        this.viewport,
    });

    final Location? location;
    final Viewport? viewport;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location!.toJson(),
        "viewport": viewport!.toJson(),
    };
}

class Location {
    Location({
        this.lat,
        this.lng,
    });

    final double? lat;
    final double? lng;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}

class Viewport {
    Viewport({
        this.northeast,
        this.southwest,
    });

    final Location? northeast;
    final Location? southwest;

    factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
    );

    Map<String, dynamic> toJson() => {
        "northeast": northeast!.toJson(),
        "southwest": southwest!.toJson(),
    };
}

class OpeningHours {
    OpeningHours({
        this.openNow,
    });

    final bool? openNow;

    factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
    );

    Map<String, dynamic> toJson() => {
        "open_now": openNow,
    };
}

class PlusCode {
    PlusCode({
        this.compoundCode,
        this.globalCode,
    });

    final String? compoundCode;
    final String? globalCode;

    factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
    );

    Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
    };
}

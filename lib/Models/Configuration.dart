// To parse this JSON data, do
//
//     final configuration = configurationFromJson(jsonString);

import 'dart:convert';

Configuration configurationFromJson(String str) => Configuration.fromJson(json.decode(str));

String configurationToJson(Configuration data) => json.encode(data.toJson());

class Configuration {
    String? homeHeadingImage;
    String? homeHeadingText;
    String? bannerImage;
    bool? showManagePackages;

    Configuration({
        this.homeHeadingImage,
        this.homeHeadingText,
        this.bannerImage,
        this.showManagePackages,
    });

    Configuration copyWith({
        String? homeHeadingImage,
        String? homeHeadingText,
        String? bannerImage,
        bool? showManagePackages,
    }) => 
        Configuration(
            homeHeadingImage: homeHeadingImage ?? this.homeHeadingImage,
            homeHeadingText: homeHeadingText ?? this.homeHeadingText,
            bannerImage: bannerImage ?? this.bannerImage,
            showManagePackages: showManagePackages ?? this.showManagePackages,
        );

    factory Configuration.fromJson(Map<String, dynamic> json) => Configuration(
        homeHeadingImage: json["homeHeadingImage"],
        homeHeadingText: json["homeHeadingText"],
        bannerImage: json["bannerImage"],
        showManagePackages: json["showManagePackages"],
    );

    Map<String, dynamic> toJson() => {
        "homeHeadingImage": homeHeadingImage,
        "homeHeadingText": homeHeadingText,
        "bannerImage": bannerImage,
        "showManagePackages": showManagePackages,
    };
}

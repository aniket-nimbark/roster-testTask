import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'usa_boxing_id')
  final  usaBoxingId;
  final String? gender;
  final double? weight;
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  @JsonKey(name: 'number_of_fights')
  final int? numberOfFights;
  @JsonKey(name: 'team_id')
  final int? teamId;
  @JsonKey(name: 'gym_name')
  final String? gymName;
  @JsonKey(name: 'picture_thumb')
  final String? pictureThumb;
  @JsonKey(name: 'is_boxer')
  final bool? isBoxer;
  @JsonKey(name: 'is_coach')
  final bool? isCoach;
  @JsonKey(name: 'is_official')
  final bool? isOfficial;
  @JsonKey(name: 'is_matchmaker')
  final bool? isMatchmaker;
  @JsonKey(name: 'is_managed_account')
  final bool? isManagedAccount;
  final int? id;
  final int? age;
  @JsonKey(name: 'gym_location_full')
  final GymLocationFull? gymLocationFull;

  User({
    this.firstName,
    this.lastName,
    this.usaBoxingId,
    this.gender,
    this.weight,
    this.dateOfBirth,
    this.numberOfFights,
    this.teamId,
    this.gymName,
    this.pictureThumb,
    this.isBoxer,
    this.isCoach,
    this.isOfficial,
    this.isMatchmaker,
    this.isManagedAccount,
    this.id,
    this.age,
    this.gymLocationFull,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class GymLocationFull {
  final String? locality;
  final String? state;
  @JsonKey(name: 'state_code')
  final String? stateCode;
  final String? country;
  @JsonKey(name: 'country_code')
  final String? countryCode;
  final String? raw;

  GymLocationFull({
    this.locality,
    this.state,
    this.stateCode,
    this.country,
    this.countryCode,
    this.raw,
  });

  factory GymLocationFull.fromJson(Map<String, dynamic> json) => _$GymLocationFullFromJson(json);
}

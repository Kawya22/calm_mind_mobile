import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiUrl = dotenv.env['API_URL']!;
final useEmulator = dotenv.env['USE_EMULATOR'] == 'true';
final hostAddress = dotenv.env['API_DOMAIN'];

const _dataTrackInterval = 10;
const _minGapForPhoneOffDetection = _dataTrackInterval * 3;

const dataTrackInterval = kDebugMode
    ? Duration(seconds: _dataTrackInterval)
    : Duration(minutes: _dataTrackInterval);
const minGapForPhoneOffDetection = kDebugMode
    ? Duration(seconds: _minGapForPhoneOffDetection)
    : Duration(minutes: _minGapForPhoneOffDetection);

const _dataUploadIntervalOnRelease = 2; // hours
const _dataUploadIntervalOnDebug = 1; // minutes
const dataUploadInterval = kDebugMode
    ? Duration(minutes: _dataUploadIntervalOnDebug)
    : Duration(hours: _dataUploadIntervalOnRelease);

const usersCollectionName = 'users';
const userRecordsCollectionName = 'user-records';
const userId = "PlW0txAnI7hqUAwLiHSf";

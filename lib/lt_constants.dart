/**
 *     'latitude': position.latitude,
    'longitude': position.longitude,
    'time': position.timestamp?.millisecondsSinceEpoch ?? 0,
    'accuracy': position.accuracy,
    'altitude': position.altitude,
    'speed': position.speed,
    'speed_accuracy': position.speedAccuracy,
    'heading': position.heading,
    'datetime': DateTime.now().toIso8601String(),
 */

/// This key will be used as SQLite location data table name and firebase location data collection name
const keyLocationData = "location_data";

/// This key will be used as SQLite location data table column name and firebase location data collection property name
const keyLatitude = "latitude";

/// This key will be used as SQLite location data table column name and firebase location data collection property name
const keyLongitude = "longitude";

/// This key will be used as SQLite location data table column name and firebase location data collection property name
const keyTime = "time";

/// This key will be used as SQLite location data table column name and firebase location data collection property name
const keyAccuracy = "accuracy";

/// This key will be used as SQLite location data table column name and firebase location data collection property name
const keyAltitude = "altitude";

/// This key will be used as SQLite location data table column name and firebase location data collection property name
const keySpeed = "speed";

/// This key will be used as SQLite location data table column name and firebase location data collection property name
const keySpeedAccuracy = "speed_accuracy";

/// This key will be used as SQLite location data table column name and firebase location data collection property name
const keyHeading = "heading";

/// This key will be used as SQLite location data table column name and firebase location data collection property name
const keyDateTime = "datetime";

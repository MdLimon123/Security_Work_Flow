/// Canonical language strings for profile verification (step two).
const List<String> kProfileVerificationLanguageValues = <String>[
  "English",
  "Mandarin",
  "Cantonese",
  "Hindi",
  "Punjabi",
  "Arabic",
  "Vietnamese",
  "Filipino / Tagalog",
  "Spanish",
  "Korean",
  "Japanese",
  "Tamil",
  "Urdu",
  "Greek",
  "Italian",
  "Turkish",
  "Russian",
  "French",
  "German",
  "Swahili",
];

/// Edit profile: same as verification plus Portuguese & Bengali (legacy API options).
const List<String> kProfileEditLanguageValues = <String>[
  ...kProfileVerificationLanguageValues,
  "Portuguese",
  "Bengali",
];

/// Maps older API/saved values to canonical [kProfileEditLanguageValues] strings.
String normalizeProfileLanguageValue(String? raw) {
  if (raw == null || raw.trim().isEmpty) return "English";
  switch (raw.trim()) {
    case "Mandarin Chinese":
      return "Mandarin";
    default:
      return raw.trim();
  }
}

/// Longer labels for the edit-profile language dropdown only.
String profileLanguageDisplayLabel(String value) {
  switch (value) {
    case "Spanish":
      return "Spanish (Latin American or Castilian)";
    case "Mandarin":
      return "Mandarin Chinese (Simplified or Traditional)";
    case "French":
      return "French (France or Canada)";
    case "Portuguese":
      return "Portuguese (Brazil or Portugal)";
    default:
      return value;
  }
}

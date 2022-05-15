// General Constants.
import 'package:flutter/material.dart';

const String APPBAR_TEXT = 'Moral Distress';
const int COLORS_UVA_BLUE = 0xFF232D4B;
const int COLORS_UVA_ORANGE = 0xFFE57200;
const double PADDING = 16.0;

// Home Route Constants.
const String HOME_BUTTON_TEXT = "What's Your Temperature?";

// Thermometer Route Constants.
const String THERMOMETER_TITLE = 'Moral Distress Thermometer';
const double THERMOMETER_TITLE_FONT_SIZE = 16.0;
const String THERMOMETER_INSTRUCTIONS = 'Please indicate on the thermometer '
    'the number that best describes how much moral distress you have been '
    'experiencing.';
const String THERMOMETER_NEXT_BUTTON = 'Continue to Questions';

// Questionnaire Route Constants.
const String SURVEY_TITLE = 'Contributing Factors to Moral Distress';
const String SURVEY_INSTRUCTIONS = 'Please check contributors to your '
    'distress.'
    '\n\n'
    'There are a variety of internal and external constraints that can '
    'contribute to the experience of moral distress. Please put a check next '
    'to any and all indicators that led to your MoD temperature rating. '
    'If other things not included in the list contributed, please select the '
    '"other" option.';
const String SURVEY_EXPAND_TEXT = 'details';
const String SURVEY_COLLAPSE_TEXT = 'less';
const String SURVEY_SUBMIT_BUTTON = 'Submit';
const String SURVEY_TOASTER_MESSAGE = 'Thank You - Your response has been '
    'recorded and will be escalated if aggregate scores are high enough.';
const int SURVEY_TOASTER_DURATION = 3;
const double SURVEY_TOASTER_FONT_SIZE = 15;
const double SURVEY_NO_SELCTIONS_REQUIRED_SCORE = 3;

// TODO: Does this path work?
const String SURVEY_QUESTIONNAIRE_PATH = '../resources/questionnaire.json';

// Submitted Route Constants.
const String SUBMITTED_TITLE = 'Thank You!';
const String SUBMITTED_SUBTITLE =
    'Your MoD score is important to us and has been recorded';
const String SUBMITTED_BODY = 'If you need immediate relief please page '
    'PIC1712 to notify the MDC';
const String SUBMITTED_BODY2 = "Swipe up for suggested resiliency resources";

// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
@HtmlImport('main_app.html')
library cbr2sota.lib.main_app;

import 'dart:html';

import 'package:hamlog/hamlog.dart';
// import 'package:hamlog/convert/cabrillo3.dart';

import 'package:polymer_elements/app_route.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_textarea.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

/// Uses [AppRoute]
/// Uses [PaperTextarea]
/// Uses [PaperInput]
/// Uses [PaperButton]
@PolymerRegister('main-app')
class MainApp extends PolymerElement {
  @property
  String page;

  @property
  String callsign;

  @property
  String sotaRef;

  @property
  String cabrillo;

  @property
  String csv;

  Log log;

  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

  @reflectable
  void fillValues(Event e, var detail) {
    log = const Cabrillo3Codec().decode(cabrillo, logType: LogType.DXPEDITION);
    if (callsign == null || callsign.isEmpty) {
      set('callsign', log.owner);
    }
    if (sotaRef == null || sotaRef.isEmpty) {
      set('sotaRef', log.name);
    }
  }

//  @Listen("convert")
  @reflectable
  void convert(Event e, var detail) {
    var out = const SotaCsvCodec().encode(log);
    set('csv', out);
  }

  // Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
//  attached() {
//    super.attached();
//  }

//  /// Called when an instance of main-app is removed from the DOM.
//  detached() {
//    super.detached();
//  }

//  /// Called when an attribute (such as a class) of an instance of
//  /// main-app is added, changed, or removed.
//  attributeChanged(String name, String oldValue, String newValue) {
//    super.attributeChanged(name, oldValue, newValue);
//  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
//  ready() {
//  }
}

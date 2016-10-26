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
  int exchCount = 0;

  @property
  String cabrillo;

  @property
  String csv;

  Log log;

  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

  @reflectable
  void fillValues(Event e, var detail) {
    this.log = const Cabrillo3Codec().decode(this.cabrillo, logType: LogType.DXPEDITION, exchCount: this.exchCount);
    if (this.callsign == null || this.callsign.isEmpty) {
      set('callsign', this.log.owner);
    }
    if (this.sotaRef == null || this.sotaRef.isEmpty) {
      set('sotaRef', this.log.name);
    }
  }

//  @Listen("convert")
  @reflectable
  void convert(Event e, var detail) {
    if (this.log == null) {
      return;
    }
    this.log.owner = this.callsign;
    this.log.name = this.sotaRef;
    var out = const SotaCsvCodec().encode(this.log);
    set('csv', out);
  }

  @reflectable
  void clear(Event e, var detail) {
    this.log = null;
    set('cabrillo', '');
    set('callsign', '');
    set('sotaRef', '');
    set('csv', '');
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

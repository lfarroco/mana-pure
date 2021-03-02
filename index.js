// Generated by purs bundle 0.13.8
var PS = {};
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Control.Apply"] = $PS["Control.Apply"] || {};
  var exports = $PS["Control.Apply"];                    
  var Apply = function (Functor0, apply) {
      this.Functor0 = Functor0;
      this.apply = apply;
  };                      
  var apply = function (dict) {
      return dict.apply;
  };
  exports["Apply"] = Apply;
  exports["apply"] = apply;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Control.Applicative"] = $PS["Control.Applicative"] || {};
  var exports = $PS["Control.Applicative"];
  var Control_Apply = $PS["Control.Apply"];        
  var Applicative = function (Apply0, pure) {
      this.Apply0 = Apply0;
      this.pure = pure;
  };
  var pure = function (dict) {
      return dict.pure;
  };
  var liftA1 = function (dictApplicative) {
      return function (f) {
          return function (a) {
              return Control_Apply.apply(dictApplicative.Apply0())(pure(dictApplicative)(f))(a);
          };
      };
  };
  exports["Applicative"] = Applicative;
  exports["pure"] = pure;
  exports["liftA1"] = liftA1;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Control.Bind"] = $PS["Control.Bind"] || {};
  var exports = $PS["Control.Bind"];
  var Bind = function (Apply0, bind) {
      this.Apply0 = Apply0;
      this.bind = bind;
  };                     
  var bind = function (dict) {
      return dict.bind;
  };
  exports["Bind"] = Bind;
  exports["bind"] = bind;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Control.Monad"] = $PS["Control.Monad"] || {};
  var exports = $PS["Control.Monad"];
  var Control_Applicative = $PS["Control.Applicative"];
  var Control_Bind = $PS["Control.Bind"];                
  var Monad = function (Applicative0, Bind1) {
      this.Applicative0 = Applicative0;
      this.Bind1 = Bind1;
  };
  var ap = function (dictMonad) {
      return function (f) {
          return function (a) {
              return Control_Bind.bind(dictMonad.Bind1())(f)(function (f$prime) {
                  return Control_Bind.bind(dictMonad.Bind1())(a)(function (a$prime) {
                      return Control_Applicative.pure(dictMonad.Applicative0())(f$prime(a$prime));
                  });
              });
          };
      };
  };
  exports["Monad"] = Monad;
  exports["ap"] = ap;
})(PS);
(function(exports) {
  "use strict";

  exports.showIntImpl = function (n) {
    return n.toString();
  };

  exports.showStringImpl = function (s) {
    var l = s.length;
    return "\"" + s.replace(
      /[\0-\x1F\x7F"\\]/g, // eslint-disable-line no-control-regex
      function (c, i) {
        switch (c) {
          case "\"":
          case "\\":
            return "\\" + c;
          case "\x07": return "\\a";
          case "\b": return "\\b";
          case "\f": return "\\f";
          case "\n": return "\\n";
          case "\r": return "\\r";
          case "\t": return "\\t";
          case "\v": return "\\v";
        }
        var k = i + 1;
        var empty = k < l && s[k] >= "0" && s[k] <= "9" ? "\\&" : "";
        return "\\" + c.charCodeAt(0).toString(10) + empty;
      }
    ) + "\"";
  };

  exports.cons = function (head) {
    return function (tail) {
      return [head].concat(tail);
    };
  };

  exports.join = function (separator) {
    return function (xs) {
      return xs.join(separator);
    };
  };
})(PS["Data.Show"] = PS["Data.Show"] || {});
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Data.Symbol"] = $PS["Data.Symbol"] || {};
  var exports = $PS["Data.Symbol"];      
  var SProxy = (function () {
      function SProxy() {

      };
      SProxy.value = new SProxy();
      return SProxy;
  })();
  var IsSymbol = function (reflectSymbol) {
      this.reflectSymbol = reflectSymbol;
  };
  var reflectSymbol = function (dict) {
      return dict.reflectSymbol;
  };
  exports["IsSymbol"] = IsSymbol;
  exports["reflectSymbol"] = reflectSymbol;
  exports["SProxy"] = SProxy;
})(PS);
(function(exports) {
  "use strict";

  exports.unsafeGet = function (label) {
    return function (rec) {
      return rec[label];
    };
  };
})(PS["Record.Unsafe"] = PS["Record.Unsafe"] || {});
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Record.Unsafe"] = $PS["Record.Unsafe"] || {};
  var exports = $PS["Record.Unsafe"];
  var $foreign = $PS["Record.Unsafe"];
  exports["unsafeGet"] = $foreign.unsafeGet;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Type.Data.RowList"] = $PS["Type.Data.RowList"] || {};
  var exports = $PS["Type.Data.RowList"];
  var RLProxy = (function () {
      function RLProxy() {

      };
      RLProxy.value = new RLProxy();
      return RLProxy;
  })();
  exports["RLProxy"] = RLProxy;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Data.Show"] = $PS["Data.Show"] || {};
  var exports = $PS["Data.Show"];
  var $foreign = $PS["Data.Show"];
  var Data_Symbol = $PS["Data.Symbol"];
  var Record_Unsafe = $PS["Record.Unsafe"];
  var Type_Data_RowList = $PS["Type.Data.RowList"];                
  var ShowRecordFields = function (showRecordFields) {
      this.showRecordFields = showRecordFields;
  };
  var Show = function (show) {
      this.show = show;
  };
  var showString = new Show($foreign.showStringImpl);
  var showRecordFieldsNil = new ShowRecordFields(function (v) {
      return function (v1) {
          return [  ];
      };
  });
  var showRecordFields = function (dict) {
      return dict.showRecordFields;
  };
  var showRecord = function (dictRowToList) {
      return function (dictShowRecordFields) {
          return new Show(function (record) {
              var v = showRecordFields(dictShowRecordFields)(Type_Data_RowList.RLProxy.value)(record);
              if (v.length === 0) {
                  return "{}";
              };
              return $foreign.join(" ")([ "{", $foreign.join(", ")(v), "}" ]);
          });
      };
  };                                                 
  var showInt = new Show($foreign.showIntImpl);
  var show = function (dict) {
      return dict.show;
  };
  var showRecordFieldsCons = function (dictIsSymbol) {
      return function (dictShowRecordFields) {
          return function (dictShow) {
              return new ShowRecordFields(function (v) {
                  return function (record) {
                      var tail = showRecordFields(dictShowRecordFields)(Type_Data_RowList.RLProxy.value)(record);
                      var key = Data_Symbol.reflectSymbol(dictIsSymbol)(Data_Symbol.SProxy.value);
                      var focus = Record_Unsafe.unsafeGet(key)(record);
                      return $foreign.cons($foreign.join(": ")([ key, show(dictShow)(focus) ]))(tail);
                  };
              });
          };
      };
  };
  exports["Show"] = Show;
  exports["show"] = show;
  exports["showInt"] = showInt;
  exports["showString"] = showString;
  exports["showRecord"] = showRecord;
  exports["showRecordFieldsNil"] = showRecordFieldsNil;
  exports["showRecordFieldsCons"] = showRecordFieldsCons;
})(PS);
(function($PS) {
  "use strict";
  $PS["Core.BoundedNumber"] = $PS["Core.BoundedNumber"] || {};
  var exports = $PS["Core.BoundedNumber"];
  var Data_Show = $PS["Data.Show"];
  var Data_Symbol = $PS["Data.Symbol"];                
  var BoundedNumber = (function () {
      function BoundedNumber(value0) {
          this.value0 = value0;
      };
      BoundedNumber.create = function (value0) {
          return new BoundedNumber(value0);
      };
      return BoundedNumber;
  })();
  var showBoundedNumber = new Data_Show.Show(function (v) {
      return Data_Show.show(Data_Show.showRecord()(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "max";
      }))(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "min";
      }))(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "value";
      }))(Data_Show.showRecordFieldsNil)(Data_Show.showInt))(Data_Show.showInt))(Data_Show.showInt)))(v.value0);
  });
  var createBoundedNumber = function ($copy_min) {
      return function ($copy_max) {
          return function ($copy_value) {
              var $tco_var_min = $copy_min;
              var $tco_var_max = $copy_max;
              var $tco_done = false;
              var $tco_result;
              function $tco_loop(min, max, value) {
                  var $5 = value < min;
                  if ($5) {
                      $tco_var_min = min;
                      $tco_var_max = max;
                      $copy_value = min;
                      return;
                  };
                  var $6 = value > max;
                  if ($6) {
                      $tco_var_min = min;
                      $tco_var_max = max;
                      $copy_value = max;
                      return;
                  };
                  $tco_done = true;
                  return new BoundedNumber({
                      min: min,
                      max: max,
                      value: value
                  });
              };
              while (!$tco_done) {
                  $tco_result = $tco_loop($tco_var_min, $tco_var_max, $copy_value);
              };
              return $tco_result;
          };
      };
  };
  exports["createBoundedNumber"] = createBoundedNumber;
  exports["showBoundedNumber"] = showBoundedNumber;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Data.Functor"] = $PS["Data.Functor"] || {};
  var exports = $PS["Data.Functor"];               
  var Functor = function (map) {
      this.map = map;
  };
  var map = function (dict) {
      return dict.map;
  };
  exports["Functor"] = Functor;
  exports["map"] = map;
})(PS);
(function(exports) {
  "use strict";

  exports.pureE = function (a) {
    return function () {
      return a;
    };
  };

  exports.bindE = function (a) {
    return function (f) {
      return function () {
        return f(a())();
      };
    };
  };
})(PS["Effect"] = PS["Effect"] || {});
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Effect"] = $PS["Effect"] || {};
  var exports = $PS["Effect"];
  var $foreign = $PS["Effect"];
  var Control_Applicative = $PS["Control.Applicative"];
  var Control_Apply = $PS["Control.Apply"];
  var Control_Bind = $PS["Control.Bind"];
  var Control_Monad = $PS["Control.Monad"];
  var Data_Functor = $PS["Data.Functor"];                    
  var monadEffect = new Control_Monad.Monad(function () {
      return applicativeEffect;
  }, function () {
      return bindEffect;
  });
  var bindEffect = new Control_Bind.Bind(function () {
      return applyEffect;
  }, $foreign.bindE);
  var applyEffect = new Control_Apply.Apply(function () {
      return functorEffect;
  }, Control_Monad.ap(monadEffect));
  var applicativeEffect = new Control_Applicative.Applicative(function () {
      return applyEffect;
  }, $foreign.pureE);
  var functorEffect = new Data_Functor.Functor(Control_Applicative.liftA1(applicativeEffect));
  exports["functorEffect"] = functorEffect;
})(PS);
(function(exports) {
  "use strict";

  exports.log = function (s) {
    return function () {
      console.log(s);
      return {};
    };
  };
})(PS["Effect.Console"] = PS["Effect.Console"] || {});
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Effect.Console"] = $PS["Effect.Console"] || {};
  var exports = $PS["Effect.Console"];
  var $foreign = $PS["Effect.Console"];
  exports["log"] = $foreign.log;
})(PS);
(function(exports) {
  "use strict";

  exports.new = function (val) {
    return function () {
      return { value: val };
    };
  };

  exports["modify'"] = function (f) {
    return function (ref) {
      return function () {
        var t = f(ref.value);
        ref.value = t.state;
        return t.value;
      };
    };
  };
})(PS["Effect.Ref"] = PS["Effect.Ref"] || {});
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Effect.Ref"] = $PS["Effect.Ref"] || {};
  var exports = $PS["Effect.Ref"];
  var $foreign = $PS["Effect.Ref"];          
  var modify = function (f) {
      return $foreign["modify'"](function (s) {
          var s$prime = f(s);
          return {
              state: s$prime,
              value: s$prime
          };
      });
  };
  exports["modify"] = modify;
  exports["new"] = $foreign["new"];
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Game.Domain"] = $PS["Game.Domain"] || {};
  var exports = $PS["Game.Domain"];
  var Core_BoundedNumber = $PS["Core.BoundedNumber"];
  var Data_Show = $PS["Data.Show"];
  var Data_Symbol = $PS["Data.Symbol"];                
  var MainScreen = (function () {
      function MainScreen() {

      };
      MainScreen.value = new MainScreen();
      return MainScreen;
  })();
  var UnitListScreen = (function () {
      function UnitListScreen() {

      };
      UnitListScreen.value = new UnitListScreen();
      return UnitListScreen;
  })();
  var Volume = (function () {
      function Volume(value0) {
          this.value0 = value0;
      };
      Volume.create = function (value0) {
          return new Volume(value0);
      };
      return Volume;
  })();
  var Options = (function () {
      function Options(value0) {
          this.value0 = value0;
      };
      Options.create = function (value0) {
          return new Options(value0);
      };
      return Options;
  })();
  var updateCounter = function (v) {
      return {
          currentScreen: v.currentScreen,
          options: v.options,
          uiScale: v.uiScale,
          counter: v.counter + 1 | 0
      };
  };
  var showVolume = new Data_Show.Show(function (v) {
      return Data_Show.show(Data_Show.showRecord()(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "audio";
      }))(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "general";
      }))(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "music";
      }))(Data_Show.showRecordFieldsNil)(Core_BoundedNumber.showBoundedNumber))(Core_BoundedNumber.showBoundedNumber))(Core_BoundedNumber.showBoundedNumber)))(v.value0);
  });
  var showScreenName = new Data_Show.Show(function (v) {
      if (v instanceof MainScreen) {
          return Data_Show.show(Data_Show.showString)("MainScreen");
      };
      if (v instanceof UnitListScreen) {
          return Data_Show.show(Data_Show.showString)("UnitListScreen");
      };
      throw new Error("Failed pattern match at Game.Domain (line 8, column 1 - line 10, column 49): " + [ v.constructor.name ]);
  });
  var showScreen = new Data_Show.Show(function (v) {
      return Data_Show.show(Data_Show.showRecord()(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "name";
      }))(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "ui";
      }))(Data_Show.showRecordFieldsNil)(Data_Show.showInt))(showScreenName)))(v);
  });
  var showOptions = new Data_Show.Show(function (v) {
      return Data_Show.show(Data_Show.showRecord()(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "volume";
      }))(Data_Show.showRecordFieldsNil)(showVolume)))(v.value0);
  });
  var showGame = new Data_Show.Show(function (v) {
      return Data_Show.show(Data_Show.showRecord()(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "counter";
      }))(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "currentScreen";
      }))(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "options";
      }))(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
          return "uiScale";
      }))(Data_Show.showRecordFieldsNil)(Core_BoundedNumber.showBoundedNumber))(showOptions))(showScreen))(Data_Show.showInt)))(v);
  });
  var initialVolume = new Volume({
      music: Core_BoundedNumber.createBoundedNumber(0)(100)(100),
      audio: Core_BoundedNumber.createBoundedNumber(0)(100)(100),
      general: Core_BoundedNumber.createBoundedNumber(0)(100)(100)
  });
  var createScreen = function (name) {
      return function (ui) {
          return {
              name: name,
              ui: ui
          };
      };
  };
  var mainScreen = createScreen(MainScreen.value)(22);
  var initialGame = {
      currentScreen: mainScreen,
      options: new Options({
          volume: initialVolume
      }),
      uiScale: Core_BoundedNumber.createBoundedNumber(0)(100)(50),
      counter: 1
  };
  exports["initialGame"] = initialGame;
  exports["updateCounter"] = updateCounter;
  exports["showGame"] = showGame;
})(PS);
(function(exports) {
  "use strict";

  exports.eventListener = function (fn) {
    return function () {
      return function (event) {
        return fn(event)();
      };
    };
  };

  exports.addEventListener = function (type) {
    return function (listener) {
      return function (useCapture) {
        return function (target) {
          return function () {
            return target.addEventListener(type, listener, useCapture);
          };
        };
      };
    };
  };
})(PS["Web.Event.EventTarget"] = PS["Web.Event.EventTarget"] || {});
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Web.Event.EventTarget"] = $PS["Web.Event.EventTarget"] || {};
  var exports = $PS["Web.Event.EventTarget"];
  var $foreign = $PS["Web.Event.EventTarget"];
  exports["eventListener"] = $foreign.eventListener;
  exports["addEventListener"] = $foreign.addEventListener;
})(PS);
(function(exports) {
  /* global window */
  "use strict";

  exports.window = function () {
    return window;
  };
})(PS["Web.HTML"] = PS["Web.HTML"] || {});
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Web.HTML"] = $PS["Web.HTML"] || {};
  var exports = $PS["Web.HTML"];
  var $foreign = $PS["Web.HTML"];
  exports["window"] = $foreign.window;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Web.HTML.Event.EventTypes"] = $PS["Web.HTML.Event.EventTypes"] || {};
  var exports = $PS["Web.HTML.Event.EventTypes"];
  var click = "click";
  exports["click"] = click;
})(PS);
(function(exports) {
  "use strict";

  // module Unsafe.Coerce

  exports.unsafeCoerce = function (x) {
    return x;
  };
})(PS["Unsafe.Coerce"] = PS["Unsafe.Coerce"] || {});
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Unsafe.Coerce"] = $PS["Unsafe.Coerce"] || {};
  var exports = $PS["Unsafe.Coerce"];
  var $foreign = $PS["Unsafe.Coerce"];
  exports["unsafeCoerce"] = $foreign.unsafeCoerce;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Web.HTML.Window"] = $PS["Web.HTML.Window"] || {};
  var exports = $PS["Web.HTML.Window"];
  var Unsafe_Coerce = $PS["Unsafe.Coerce"];
  var toEventTarget = Unsafe_Coerce.unsafeCoerce;
  exports["toEventTarget"] = toEventTarget;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Main"] = $PS["Main"] || {};
  var exports = $PS["Main"];
  var Data_Functor = $PS["Data.Functor"];
  var Data_Show = $PS["Data.Show"];
  var Effect = $PS["Effect"];
  var Effect_Console = $PS["Effect.Console"];
  var Effect_Ref = $PS["Effect.Ref"];
  var Game_Domain = $PS["Game.Domain"];
  var Web_Event_EventTarget = $PS["Web.Event.EventTarget"];
  var Web_HTML = $PS["Web.HTML"];
  var Web_HTML_Event_EventTypes = $PS["Web.HTML.Event.EventTypes"];
  var Web_HTML_Window = $PS["Web.HTML.Window"];                
  var main = function __do() {
      var ref = Effect_Ref["new"](Game_Domain.initialGame)();
      var target = Data_Functor.map(Effect.functorEffect)(Web_HTML_Window.toEventTarget)(Web_HTML.window)();
      var clickListener = Web_Event_EventTarget.eventListener(function (e) {
          return function __do() {
              var newVal = Effect_Ref.modify(Game_Domain.updateCounter)(ref)();
              return Effect_Console.log(Data_Show.show(Game_Domain.showGame)(newVal))();
          };
      })();
      return Web_Event_EventTarget.addEventListener(Web_HTML_Event_EventTypes.click)(clickListener)(true)(target)();
  };
  exports["main"] = main;
})(PS);
PS["Main"].main();
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
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Data.Eq"] = $PS["Data.Eq"] || {};
  var exports = $PS["Data.Eq"];
  var Eq = function (eq) {
      this.eq = eq;
  };
  exports["Eq"] = Eq;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Data.Function"] = $PS["Data.Function"] || {};
  var exports = $PS["Data.Function"];
  var $$const = function (a) {
      return function (v) {
          return a;
      };
  };
  exports["const"] = $$const;
})(PS);
(function(exports) {
  "use strict";

  exports.unit = {};
})(PS["Data.Unit"] = PS["Data.Unit"] || {});
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Data.Unit"] = $PS["Data.Unit"] || {};
  var exports = $PS["Data.Unit"];
  var $foreign = $PS["Data.Unit"];
  exports["unit"] = $foreign.unit;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Data.Functor"] = $PS["Data.Functor"] || {};
  var exports = $PS["Data.Functor"];
  var Data_Function = $PS["Data.Function"];
  var Data_Unit = $PS["Data.Unit"];                
  var Functor = function (map) {
      this.map = map;
  };
  var map = function (dict) {
      return dict.map;
  };
  var $$void = function (dictFunctor) {
      return map(dictFunctor)(Data_Function["const"](Data_Unit.unit));
  };
  exports["Functor"] = Functor;
  exports["void"] = $$void;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Data.List.Types"] = $PS["Data.List.Types"] || {};
  var exports = $PS["Data.List.Types"];                          
  var Nil = (function () {
      function Nil() {

      };
      Nil.value = new Nil();
      return Nil;
  })();
  var Cons = (function () {
      function Cons(value0, value1) {
          this.value0 = value0;
          this.value1 = value1;
      };
      Cons.create = function (value0) {
          return function (value1) {
              return new Cons(value0, value1);
          };
      };
      return Cons;
  })();
  exports["Nil"] = Nil;
  exports["Cons"] = Cons;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Data.Ord"] = $PS["Data.Ord"] || {};
  var exports = $PS["Data.Ord"];
  var Ord = function (Eq0, compare) {
      this.Eq0 = Eq0;
      this.compare = compare;
  };
  var compare = function (dict) {
      return dict.compare;
  };
  exports["Ord"] = Ord;
  exports["compare"] = compare;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Data.Ordering"] = $PS["Data.Ordering"] || {};
  var exports = $PS["Data.Ordering"];              
  var LT = (function () {
      function LT() {

      };
      LT.value = new LT();
      return LT;
  })();
  var GT = (function () {
      function GT() {

      };
      GT.value = new GT();
      return GT;
  })();
  var EQ = (function () {
      function EQ() {

      };
      EQ.value = new EQ();
      return EQ;
  })();
  exports["LT"] = LT;
  exports["GT"] = GT;
  exports["EQ"] = EQ;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Data.Map.Internal"] = $PS["Data.Map.Internal"] || {};
  var exports = $PS["Data.Map.Internal"];
  var Data_List_Types = $PS["Data.List.Types"];
  var Data_Ord = $PS["Data.Ord"];
  var Data_Ordering = $PS["Data.Ordering"];                    
  var Leaf = (function () {
      function Leaf() {

      };
      Leaf.value = new Leaf();
      return Leaf;
  })();
  var Two = (function () {
      function Two(value0, value1, value2, value3) {
          this.value0 = value0;
          this.value1 = value1;
          this.value2 = value2;
          this.value3 = value3;
      };
      Two.create = function (value0) {
          return function (value1) {
              return function (value2) {
                  return function (value3) {
                      return new Two(value0, value1, value2, value3);
                  };
              };
          };
      };
      return Two;
  })();
  var Three = (function () {
      function Three(value0, value1, value2, value3, value4, value5, value6) {
          this.value0 = value0;
          this.value1 = value1;
          this.value2 = value2;
          this.value3 = value3;
          this.value4 = value4;
          this.value5 = value5;
          this.value6 = value6;
      };
      Three.create = function (value0) {
          return function (value1) {
              return function (value2) {
                  return function (value3) {
                      return function (value4) {
                          return function (value5) {
                              return function (value6) {
                                  return new Three(value0, value1, value2, value3, value4, value5, value6);
                              };
                          };
                      };
                  };
              };
          };
      };
      return Three;
  })();
  var TwoLeft = (function () {
      function TwoLeft(value0, value1, value2) {
          this.value0 = value0;
          this.value1 = value1;
          this.value2 = value2;
      };
      TwoLeft.create = function (value0) {
          return function (value1) {
              return function (value2) {
                  return new TwoLeft(value0, value1, value2);
              };
          };
      };
      return TwoLeft;
  })();
  var TwoRight = (function () {
      function TwoRight(value0, value1, value2) {
          this.value0 = value0;
          this.value1 = value1;
          this.value2 = value2;
      };
      TwoRight.create = function (value0) {
          return function (value1) {
              return function (value2) {
                  return new TwoRight(value0, value1, value2);
              };
          };
      };
      return TwoRight;
  })();
  var ThreeLeft = (function () {
      function ThreeLeft(value0, value1, value2, value3, value4, value5) {
          this.value0 = value0;
          this.value1 = value1;
          this.value2 = value2;
          this.value3 = value3;
          this.value4 = value4;
          this.value5 = value5;
      };
      ThreeLeft.create = function (value0) {
          return function (value1) {
              return function (value2) {
                  return function (value3) {
                      return function (value4) {
                          return function (value5) {
                              return new ThreeLeft(value0, value1, value2, value3, value4, value5);
                          };
                      };
                  };
              };
          };
      };
      return ThreeLeft;
  })();
  var ThreeMiddle = (function () {
      function ThreeMiddle(value0, value1, value2, value3, value4, value5) {
          this.value0 = value0;
          this.value1 = value1;
          this.value2 = value2;
          this.value3 = value3;
          this.value4 = value4;
          this.value5 = value5;
      };
      ThreeMiddle.create = function (value0) {
          return function (value1) {
              return function (value2) {
                  return function (value3) {
                      return function (value4) {
                          return function (value5) {
                              return new ThreeMiddle(value0, value1, value2, value3, value4, value5);
                          };
                      };
                  };
              };
          };
      };
      return ThreeMiddle;
  })();
  var ThreeRight = (function () {
      function ThreeRight(value0, value1, value2, value3, value4, value5) {
          this.value0 = value0;
          this.value1 = value1;
          this.value2 = value2;
          this.value3 = value3;
          this.value4 = value4;
          this.value5 = value5;
      };
      ThreeRight.create = function (value0) {
          return function (value1) {
              return function (value2) {
                  return function (value3) {
                      return function (value4) {
                          return function (value5) {
                              return new ThreeRight(value0, value1, value2, value3, value4, value5);
                          };
                      };
                  };
              };
          };
      };
      return ThreeRight;
  })();
  var KickUp = (function () {
      function KickUp(value0, value1, value2, value3) {
          this.value0 = value0;
          this.value1 = value1;
          this.value2 = value2;
          this.value3 = value3;
      };
      KickUp.create = function (value0) {
          return function (value1) {
              return function (value2) {
                  return function (value3) {
                      return new KickUp(value0, value1, value2, value3);
                  };
              };
          };
      };
      return KickUp;
  })();
  var fromZipper = function ($copy_dictOrd) {
      return function ($copy_v) {
          return function ($copy_tree) {
              var $tco_var_dictOrd = $copy_dictOrd;
              var $tco_var_v = $copy_v;
              var $tco_done = false;
              var $tco_result;
              function $tco_loop(dictOrd, v, tree) {
                  if (v instanceof Data_List_Types.Nil) {
                      $tco_done = true;
                      return tree;
                  };
                  if (v instanceof Data_List_Types.Cons) {
                      if (v.value0 instanceof TwoLeft) {
                          $tco_var_dictOrd = dictOrd;
                          $tco_var_v = v.value1;
                          $copy_tree = new Two(tree, v.value0.value0, v.value0.value1, v.value0.value2);
                          return;
                      };
                      if (v.value0 instanceof TwoRight) {
                          $tco_var_dictOrd = dictOrd;
                          $tco_var_v = v.value1;
                          $copy_tree = new Two(v.value0.value0, v.value0.value1, v.value0.value2, tree);
                          return;
                      };
                      if (v.value0 instanceof ThreeLeft) {
                          $tco_var_dictOrd = dictOrd;
                          $tco_var_v = v.value1;
                          $copy_tree = new Three(tree, v.value0.value0, v.value0.value1, v.value0.value2, v.value0.value3, v.value0.value4, v.value0.value5);
                          return;
                      };
                      if (v.value0 instanceof ThreeMiddle) {
                          $tco_var_dictOrd = dictOrd;
                          $tco_var_v = v.value1;
                          $copy_tree = new Three(v.value0.value0, v.value0.value1, v.value0.value2, tree, v.value0.value3, v.value0.value4, v.value0.value5);
                          return;
                      };
                      if (v.value0 instanceof ThreeRight) {
                          $tco_var_dictOrd = dictOrd;
                          $tco_var_v = v.value1;
                          $copy_tree = new Three(v.value0.value0, v.value0.value1, v.value0.value2, v.value0.value3, v.value0.value4, v.value0.value5, tree);
                          return;
                      };
                      throw new Error("Failed pattern match at Data.Map.Internal (line 418, column 3 - line 423, column 88): " + [ v.value0.constructor.name ]);
                  };
                  throw new Error("Failed pattern match at Data.Map.Internal (line 415, column 1 - line 415, column 80): " + [ v.constructor.name, tree.constructor.name ]);
              };
              while (!$tco_done) {
                  $tco_result = $tco_loop($tco_var_dictOrd, $tco_var_v, $copy_tree);
              };
              return $tco_result;
          };
      };
  };
  var insert = function (dictOrd) {
      return function (k) {
          return function (v) {
              var up = function ($copy_v1) {
                  return function ($copy_v2) {
                      var $tco_var_v1 = $copy_v1;
                      var $tco_done = false;
                      var $tco_result;
                      function $tco_loop(v1, v2) {
                          if (v1 instanceof Data_List_Types.Nil) {
                              $tco_done = true;
                              return new Two(v2.value0, v2.value1, v2.value2, v2.value3);
                          };
                          if (v1 instanceof Data_List_Types.Cons) {
                              if (v1.value0 instanceof TwoLeft) {
                                  $tco_done = true;
                                  return fromZipper(dictOrd)(v1.value1)(new Three(v2.value0, v2.value1, v2.value2, v2.value3, v1.value0.value0, v1.value0.value1, v1.value0.value2));
                              };
                              if (v1.value0 instanceof TwoRight) {
                                  $tco_done = true;
                                  return fromZipper(dictOrd)(v1.value1)(new Three(v1.value0.value0, v1.value0.value1, v1.value0.value2, v2.value0, v2.value1, v2.value2, v2.value3));
                              };
                              if (v1.value0 instanceof ThreeLeft) {
                                  $tco_var_v1 = v1.value1;
                                  $copy_v2 = new KickUp(new Two(v2.value0, v2.value1, v2.value2, v2.value3), v1.value0.value0, v1.value0.value1, new Two(v1.value0.value2, v1.value0.value3, v1.value0.value4, v1.value0.value5));
                                  return;
                              };
                              if (v1.value0 instanceof ThreeMiddle) {
                                  $tco_var_v1 = v1.value1;
                                  $copy_v2 = new KickUp(new Two(v1.value0.value0, v1.value0.value1, v1.value0.value2, v2.value0), v2.value1, v2.value2, new Two(v2.value3, v1.value0.value3, v1.value0.value4, v1.value0.value5));
                                  return;
                              };
                              if (v1.value0 instanceof ThreeRight) {
                                  $tco_var_v1 = v1.value1;
                                  $copy_v2 = new KickUp(new Two(v1.value0.value0, v1.value0.value1, v1.value0.value2, v1.value0.value3), v1.value0.value4, v1.value0.value5, new Two(v2.value0, v2.value1, v2.value2, v2.value3));
                                  return;
                              };
                              throw new Error("Failed pattern match at Data.Map.Internal (line 454, column 5 - line 459, column 108): " + [ v1.value0.constructor.name, v2.constructor.name ]);
                          };
                          throw new Error("Failed pattern match at Data.Map.Internal (line 451, column 3 - line 451, column 56): " + [ v1.constructor.name, v2.constructor.name ]);
                      };
                      while (!$tco_done) {
                          $tco_result = $tco_loop($tco_var_v1, $copy_v2);
                      };
                      return $tco_result;
                  };
              };
              var comp = Data_Ord.compare(dictOrd);
              var down = function ($copy_ctx) {
                  return function ($copy_v1) {
                      var $tco_var_ctx = $copy_ctx;
                      var $tco_done = false;
                      var $tco_result;
                      function $tco_loop(ctx, v1) {
                          if (v1 instanceof Leaf) {
                              $tco_done = true;
                              return up(ctx)(new KickUp(Leaf.value, k, v, Leaf.value));
                          };
                          if (v1 instanceof Two) {
                              var v2 = comp(k)(v1.value1);
                              if (v2 instanceof Data_Ordering.EQ) {
                                  $tco_done = true;
                                  return fromZipper(dictOrd)(ctx)(new Two(v1.value0, k, v, v1.value3));
                              };
                              if (v2 instanceof Data_Ordering.LT) {
                                  $tco_var_ctx = new Data_List_Types.Cons(new TwoLeft(v1.value1, v1.value2, v1.value3), ctx);
                                  $copy_v1 = v1.value0;
                                  return;
                              };
                              $tco_var_ctx = new Data_List_Types.Cons(new TwoRight(v1.value0, v1.value1, v1.value2), ctx);
                              $copy_v1 = v1.value3;
                              return;
                          };
                          if (v1 instanceof Three) {
                              var v3 = comp(k)(v1.value1);
                              if (v3 instanceof Data_Ordering.EQ) {
                                  $tco_done = true;
                                  return fromZipper(dictOrd)(ctx)(new Three(v1.value0, k, v, v1.value3, v1.value4, v1.value5, v1.value6));
                              };
                              var v4 = comp(k)(v1.value4);
                              if (v4 instanceof Data_Ordering.EQ) {
                                  $tco_done = true;
                                  return fromZipper(dictOrd)(ctx)(new Three(v1.value0, v1.value1, v1.value2, v1.value3, k, v, v1.value6));
                              };
                              if (v3 instanceof Data_Ordering.LT) {
                                  $tco_var_ctx = new Data_List_Types.Cons(new ThreeLeft(v1.value1, v1.value2, v1.value3, v1.value4, v1.value5, v1.value6), ctx);
                                  $copy_v1 = v1.value0;
                                  return;
                              };
                              if (v3 instanceof Data_Ordering.GT && v4 instanceof Data_Ordering.LT) {
                                  $tco_var_ctx = new Data_List_Types.Cons(new ThreeMiddle(v1.value0, v1.value1, v1.value2, v1.value4, v1.value5, v1.value6), ctx);
                                  $copy_v1 = v1.value3;
                                  return;
                              };
                              $tco_var_ctx = new Data_List_Types.Cons(new ThreeRight(v1.value0, v1.value1, v1.value2, v1.value3, v1.value4, v1.value5), ctx);
                              $copy_v1 = v1.value6;
                              return;
                          };
                          throw new Error("Failed pattern match at Data.Map.Internal (line 434, column 3 - line 434, column 55): " + [ ctx.constructor.name, v1.constructor.name ]);
                      };
                      while (!$tco_done) {
                          $tco_result = $tco_loop($tco_var_ctx, $copy_v1);
                      };
                      return $tco_result;
                  };
              };
              return down(Data_List_Types.Nil.value);
          };
      };
  };
  var empty = Leaf.value;
  exports["empty"] = empty;
  exports["insert"] = insert;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Data.Maybe"] = $PS["Data.Maybe"] || {};
  var exports = $PS["Data.Maybe"];                 
  var Nothing = (function () {
      function Nothing() {

      };
      Nothing.value = new Nothing();
      return Nothing;
  })();
  var Just = (function () {
      function Just(value0) {
          this.value0 = value0;
      };
      Just.create = function (value0) {
          return new Just(value0);
      };
      return Just;
  })();
  exports["Nothing"] = Nothing;
  exports["Just"] = Just;
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
  /* global exports */
  "use strict";

  exports.getCanvasElementByIdImpl = function(id, Just, Nothing) {
      return function() {
          var el = document.getElementById(id);
          if (el && el instanceof HTMLCanvasElement) {
              return Just(el);
          } else {
              return Nothing;
          }
      };
  };

  exports.getContext2D = function(c) {
      return function() {
          return c.getContext('2d');
      };
  };

  exports.setFillStyle = function(ctx) {
      return function(style) {
          return function() {
              ctx.fillStyle = style;
          };
      };
  };

  exports.beginPath = function(ctx) {
      return function() {
          ctx.beginPath();
      };
  };

  exports.fill = function(ctx) {
      return function() {
          ctx.fill();
      };
  };

  exports.rect = function(ctx) {
      return function(r) {
          return function() {
              ctx.rect(r.x, r.y, r.width, r.height);
          };
      };
  };
})(PS["Graphics.Canvas"] = PS["Graphics.Canvas"] || {});
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Graphics.Canvas"] = $PS["Graphics.Canvas"] || {};
  var exports = $PS["Graphics.Canvas"];
  var $foreign = $PS["Graphics.Canvas"];
  var Data_Maybe = $PS["Data.Maybe"];
  var getCanvasElementById = function (elId) {
      return $foreign.getCanvasElementByIdImpl(elId, Data_Maybe.Just.create, Data_Maybe.Nothing.value);
  };
  var fillPath = function (ctx) {
      return function (path) {
          return function __do() {
              $foreign.beginPath(ctx)();
              var a = path();
              $foreign.fill(ctx)();
              return a;
          };
      };
  };
  exports["getCanvasElementById"] = getCanvasElementById;
  exports["fillPath"] = fillPath;
  exports["getContext2D"] = $foreign.getContext2D;
  exports["setFillStyle"] = $foreign.setFillStyle;
  exports["rect"] = $foreign.rect;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Main"] = $PS["Main"] || {};
  var exports = $PS["Main"];
  var Data_Eq = $PS["Data.Eq"];
  var Data_Functor = $PS["Data.Functor"];
  var Data_Map_Internal = $PS["Data.Map.Internal"];
  var Data_Maybe = $PS["Data.Maybe"];
  var Data_Ord = $PS["Data.Ord"];
  var Data_Ordering = $PS["Data.Ordering"];
  var Effect = $PS["Effect"];
  var Effect_Console = $PS["Effect.Console"];
  var Graphics_Canvas = $PS["Graphics.Canvas"];                
  var START = (function () {
      function START() {

      };
      START.value = new START();
      return START;
  })();
  var END = (function () {
      function END() {

      };
      END.value = new END();
      return END;
  })();
  var CharaName = (function () {
      function CharaName(value0) {
          this.value0 = value0;
      };
      CharaName.create = function (value0) {
          return new CharaName(value0);
      };
      return CharaName;
  })();
  var Age = (function () {
      function Age(value0) {
          this.value0 = value0;
      };
      Age.create = function (value0) {
          return new Age(value0);
      };
      return Age;
  })();
  var square = function (ctx) {
      return Graphics_Canvas.rect(ctx)({
          x: 250.0,
          y: 250.0,
          width: 100.0,
          height: 100.0
      });
  };
  var main = Data_Functor["void"](Effect.functorEffect)(function __do() {
      var v = Graphics_Canvas.getCanvasElementById("canvas")();
      if (v instanceof Data_Maybe.Just) {
          var ctx = Graphics_Canvas.getContext2D(v.value0)();
          Graphics_Canvas.setFillStyle(ctx)("#0000FF")();
          return Graphics_Canvas.fillPath(ctx)(square(ctx))();
      };
      throw new Error("Failed pattern match at Main (line 52, column 3 - line 52, column 47): " + [ v.constructor.name ]);
  });
  var eqEventName = new Data_Eq.Eq(function (x) {
      return function (y) {
          if (x instanceof START && y instanceof START) {
              return true;
          };
          if (x instanceof END && y instanceof END) {
              return true;
          };
          return false;
      };
  });
  var ordEventName = new Data_Ord.Ord(function () {
      return eqEventName;
  }, function (x) {
      return function (y) {
          if (x instanceof START && y instanceof START) {
              return Data_Ordering.EQ.value;
          };
          if (x instanceof START) {
              return Data_Ordering.LT.value;
          };
          if (y instanceof START) {
              return Data_Ordering.GT.value;
          };
          if (x instanceof END && y instanceof END) {
              return Data_Ordering.EQ.value;
          };
          throw new Error("Failed pattern match at Main (line 31, column 1 - line 31, column 46): " + [ x.constructor.name, y.constructor.name ]);
      };
  });
  var index = Data_Map_Internal.insert(ordEventName)(END.value)("bbbb")(Data_Map_Internal.insert(ordEventName)(START.value)("aaa")(Data_Map_Internal.empty));
  var emit = function (eventName) {
      if (eventName instanceof START) {
          return Effect_Console.log("xaxxa");
      };
      if (eventName instanceof END) {
          return Effect_Console.log("zazaza");
      };
      throw new Error("Failed pattern match at Main (line 40, column 3 - line 42, column 27): " + [ eventName.constructor.name ]);
  };
  var createCharaName = function (s) {
      return new CharaName({
          value: s
      });
  };
  var createAge = function (s) {
      return new Age({
          value: s
      });
  };
  var createChara = function (name) {
      return function (age) {
          return {
              name: createCharaName(name),
              age: createAge(age)
          };
      };
  };
  exports["CharaName"] = CharaName;
  exports["createCharaName"] = createCharaName;
  exports["Age"] = Age;
  exports["createAge"] = createAge;
  exports["createChara"] = createChara;
  exports["START"] = START;
  exports["END"] = END;
  exports["index"] = index;
  exports["emit"] = emit;
  exports["square"] = square;
  exports["main"] = main;
  exports["eqEventName"] = eqEventName;
  exports["ordEventName"] = ordEventName;
})(PS);
PS["Main"].main();
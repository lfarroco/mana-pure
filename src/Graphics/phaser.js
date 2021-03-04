'use strict';

exports.newGame = function (width) {
  return function (height) {
    return function () {
      const config = {
        type: Phaser.AUTO,
        width,
        height,
      };

      const game = new Phaser.Game(config);

      // for debugging
      window.game = game;
      return game;
    };
  };
};

exports.createScene_ = function (game) {
  return function (name) {
    return function (onError, onSuccess) {
      game.scene.add(
        name,
        {
          preload: function () {
            ['backgrounds/sunset'].forEach((str) =>
              this.load.image(str, 'assets/' + str + '.svg')
            );
          },
          create: function () {
            onSuccess(this);
          },
        },
        true
      );
      return function (cancelError, cancelerError, cancelerSuccess) {
        req.cancel(); // cancel the request
        cancelerSuccess(); // invoke the success callback for the canceler
      };
    };
  };
};

exports.addContainer = function (scene) {
  return function (x) {
    return function (y) {
      return function () {
        return scene.add.container(x, y);
      };
    };
  };
};

exports.addImage = function (scene) {
  return function (x) {
    return function (y) {
      return function (texture) {
        return function () {
          return scene.add.image(x, y, texture);
        };
      };
    };
  };
};

exports.setImageDisplaySize = function (image) {
  return function (width) {
    return function (height) {
      return function () {
        return image.setDisplaySize(width, height);
      };
    };
  };
};
exports.setImageOrigin = function (image) {
  return function (x) {
    return function (y) {
      return function () {
        return image.setOrigin(x, y);
      };
    };
  };
};
exports.addTween = function (scene) {
  return function (targets) {
    return function (delay) {
      return function (x) {
        return function (y) {
          return function (duration) {
            return function (ease) {
              return function (repeat) {
                return function (yoyo) {
                  return function () {
                    // use tween.setCallBack to define callback
                    return scene.add.tween({
                      targets,
                      delay,
                      duration,
                      ease,
                      repeat,
                      yoyo,
                      x,
                      y,
                    });
                  };
                };
              };
            };
          };
        };
      };
    };
  };
};
exports.delay_ = function (scene) {
  return function (delay) {
    return function (onError, onSuccess) {
      scene.time.addEvent({
        delay,
        callback: onSuccess,
      });
      return function (cancelError, cancelerError, cancelerSuccess) {
        req.cancel(); // cancel the request
        cancelerSuccess(); // invoke the success callback for the canceler
      };
    };
  };
};

exports.text = function ({ scene, x, y, text, config }) {
  return function () {
    return scene.add.text(x, y, text, config);
  };
};
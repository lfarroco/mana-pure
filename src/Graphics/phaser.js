'use strict';

exports.newGame = function (width) {
  return function (height) {
    return function () {
      const config = {
        type: Phaser.AUTO,
        width,
        height,
      };

      return new Phaser.Game(config);
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
  return function ({ x, y }) {
    return function () {
      return scene.add.container(x, y);
    };
  };
};
exports.setContainerSize = function (container) {
  return function ({ width, height }) {
    return function () {
      container.setSize(width, height);
      return container;
    };
  };
};

exports.addToContainer = function ({ element, container }) {
  return function () {
    return container.add(element);
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
        req.cancel();
        cancelerSuccess();
      };
    };
  };
};

exports.text = function ({ scene, pos, text, config }) {
  return function () {
    return scene.add.text(pos.x, pos.y, text, config);
  };
};

exports.imageOnPointerUp = function (image) {
  return function (listener) {
    return function () {
      image.setInteractive();
      image.on('pointerup', function () {
        listener()();
      });
    };
  };
};
exports.containerOnPointerUp = function (container) {
  return function (listener) {
    debugger;
    return function () {
      container.setInteractive();

      debugger;
      container.on('pointerup', function () {
        listener()();
      });
      return {};
    };
  };
};

exports.solidColorRect = function (scene) {
  return function (pos) {
    return function (size) {
      return function (color) {
        return function () {
          const btn = scene.add.graphics();

          const { x, y } = pos;
          const { width, height } = size;

          btn.fillStyle(color, 1);

          //btn.lineStyle(2, 0xcdc0b7, 1);

          btn.fillRect(x, y, width, height);
          console.log(btn);
          return btn;
        };
      };
    };
  };
};

exports.gradientRect = function ({ scene, pos, size, colors }) {
  const btn = scene.add.graphics();
  const { x, y } = pos;
  const { width, height } = size;
  const { topLeft, topRight, bottomLeft, bottomRight } = colors;

  btn.fillGradientStyle(topLeft, topRight, bottomLeft, bottomRight, 1);

  btn.fillRect(x, y, width, height);
};

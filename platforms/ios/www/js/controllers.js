angular.module('starter.controllers', []).controller('AppCtrl', function($scope, $ionicModal, $timeout) {
  $scope.menuItems = [
    {
      name: 'app.main',
      title: '我是吃货'
    }, {
      name: 'app.chief.home',
      title: '我是大厨'
    }
  ];
  $scope.loginData = {};
  $ionicModal.fromTemplateUrl('templates/login.html', {
    scope: $scope
  }).then(function(modal) {
    return $scope.modal = modal;
  });
  $scope.closeLogin = function() {
    return $scope.modal.hide();
  };
  $scope.login = function() {
    return $scope.modal.show();
  };
  return $scope.doLogin = function() {
    console.log('Doing login', $scope.loginData);
    return $timeout(function() {
      return $scope.closeLogin();
    }, 1000);
  };
}).controller('EaterylistCtrl', function($scope, $http, $state) {
  var s;
  s = $scope;
  angular.extend(s, {
    eateries: void 0,
    getEateries: function() {
      return $http.get('api/eateries').success(function(eateries) {
        eateries.forEach(function(eatery) {
          eatery.likes = 12;
          eatery.eats = 20;
          eatery.$shifts = [
            {
              'time': '今天19:00',
              capacity: 5,
              orders: [1, 2, 3],
              price: 20
            }, {
              'time': '明天19:00',
              capacity: 5,
              orders: [1, 2],
              price: 20
            }, {
              'time': '9月4号19:00',
              capacity: 5,
              orders: [1, 2, 3, 4, 5]
            }, {
              'time': '11月10号19:00',
              capacity: 5,
              orders: [1, 2, 3, 4]
            }, {
              price: 20
            }
          ];
          return eatery.$shift = eatery.$shifts[0];
        });
        return s.eateries = eateries;
      });
    },
    viewEateryDetail: function(eatery) {
      return $state.go('app.eateryDetail', {
        eateryId: eatery._id
      });
    },
    onJoin: function($event, eatery) {
      return $event.stopPropagation();
    }
  });
  return s.getEateries();
}).controller('EaterydetailCtrl', function($scope, $http, $state, $ionicScrollDelegate) {
  var s;
  s = $scope;
  angular.extend(s, {
    eatery: void 0,
    newComment: {},
    getEatery: function() {
      return $http.get('api/eateries/' + $state.params.eateryId).success(function(eatery) {
        eatery.likes = 12;
        eatery.eats = 20;
        eatery.$shifts = [
          {
            'time': '今天19:00',
            capacity: 5,
            orders: [1, 2, 3],
            price: 20
          }, {
            'time': '明天19:00',
            capacity: 5,
            orders: [1, 2],
            price: 30
          }, {
            'time': '9月4号19:00',
            capacity: 5,
            orders: [1, 2, 3, 4, 5],
            price: 20
          }, {
            'time': '11月10号19:00',
            capacity: 5,
            orders: [1, 2, 3, 4]
          }, {
            price: 20
          }
        ];
        eatery.$shift = eatery.$shifts[0];
        eatery.$comments = [
          {
            content: '很好吃'
          }, {
            content: '女主人很漂亮'
          }
        ];
        return s.eatery = eatery;
      });
    },
    toggleCollect: function() {
      return this.eatery.$collected = !this.eatery.$collected;
    },
    gotoComments: function() {
      return $ionicScrollDelegate.scrollBottom(true);
    },
    sendComment: function() {
      this.eatery.$comments.push(angular.copy(this.newComment));
      return this.newComment.content = '';
    }
  });
  return s.getEatery();
}).controller('ChiefHomeCtrl', function($scope, $http, $ionicScrollDelegate, Camera) {
  var s;
  s = $scope;
  angular.extend(s, {
    eatery: void 0,
    oldEatery: void 0,
    newComment: {},
    getMyEatery: function() {
      return $http.get('api/eateries?own=true').success(function(eateries) {
        var eatery;
        $http.get('api/eateries/' + eateries[0]._id).success(function(data) {
          return angular.extend(s.eatery, data);
        });
        eatery = eateries[0];
        eatery.likes = 12;
        eatery.eats = 20;
        eatery.$shifts = [
          {
            'time': '今天19:00',
            capacity: 5,
            orders: [1, 2, 3],
            price: 20
          }, {
            'time': '明天19:00',
            capacity: 5,
            orders: [1, 2],
            price: 30
          }, {
            'time': '9月4号19:00',
            capacity: 5,
            orders: [1, 2, 3, 4, 5],
            price: 20
          }, {
            'time': '11月10号19:00',
            capacity: 5,
            orders: [1, 2, 3, 4]
          }, {
            price: 20
          }
        ];
        eatery.$shift = eatery.$shifts[0];
        eatery.$comments = [
          {
            content: '很好吃'
          }, {
            content: '女主人很漂亮'
          }
        ];
        s.oldEatery = angular.copy(eatery);
        return s.eatery = eatery;
      });
    },
    toggleCollect: function() {
      return this.eatery.$collected = !this.eatery.$collected;
    },
    gotoComments: function() {
      return $ionicScrollDelegate.scrollBottom(true);
    },
    sendComment: function() {
      this.eatery.$comments.push(angular.copy(this.newComment));
      return this.newComment.content = '';
    },
    getPhoto: function() {
      var _ref;
      return Camera.getPicture().then(function(imageURI) {
        s.eatery.$newImage = imageURI;
        s.eatery.background = s.eatery.$newImage;
        return $http.put('api/eateries/' + s.eatery._id, {
          background: s.eatery.background
        });
      }, function(err) {
        return console.err(err);
      }, {
        quality: 75,
        targetWidth: 320,
        targetHeight: 320,
        saveToPhotoAlbum: true,
        destinationType: (_ref = navigator.camera.DestinationType) != null ? _ref.FILE_URI : void 0
      });
    },
    changeDishPhoto: function(dish) {
      var _ref;
      return Camera.getPicture().then(function(imageURI) {
        dish.image = imageURI;
        return $http.put('api/dishes/' + dish._id, {
          image: imageURI
        });
      }, function(err) {
        return console.err(err);
      }, {
        quality: 75,
        targetWidth: 320,
        targetHeight: 320,
        saveToPhotoAlbum: true,
        destinationType: (_ref = navigator.camera.DestinationType) != null ? _ref.FILE_URI : void 0
      });
    },
    saveDish: function(dish) {
      return $http.put('api/dishes/' + dish._id, dish).success(function(data) {
        return angular.extend(dish, data);
      });
    },
    patchEatery: function(field) {
      var patch;
      patch = {};
      patch[field] = this.eatery[field];
      if (patch[field] === this.oldEatery[field]) {
        return;
      }
      return $http.put('api/eateries/' + s.eatery._id, patch).success(function(eatery) {
        $scope.eatery._v = eatery._v;
        return angular.extend($scope.oldEatery, $scope.eatery);
      });
    },
    deleteDish: function(dish) {
      return $http["delete"]('api/dishes/' + dish._id).success(function() {
        s.eatery.dishes.splice(s.eatery.dishes.indexOf(dish), 1);
        return $http.put('api/eateries/' + s.eatery._id, {
          dishes: s.eatery.dishes.map(function(i) {
            return i._id;
          })
        }).success(function(eatery) {
          $scope.eatery._v = eatery._v;
          return angular.extend($scope.oldEatery, $scope.eatery);
        });
      });
    },
    addDish: function() {
      return $http.post('api/dishes').success(function(data) {
        s.eatery.dishes.push(data);
        return $http.put('api/eateries/' + s.eatery._id, {
          dishes: s.eatery.dishes.map(function(i) {
            return i._id;
          })
        }).success(function(eatery) {
          $scope.eatery._v = eatery._v;
          return angular.extend($scope.oldEatery, $scope.eatery);
        });
      });
    }
  });
  return s.getMyEatery();
}).controller('PlaylistsCtrl', function($scope) {
  return $scope.playlists = [
    {
      title: 'Reggae',
      id: 1
    }, {
      title: 'Chill',
      id: 2
    }, {
      title: 'Dubstep',
      id: 3
    }, {
      title: 'Indie',
      id: 4
    }, {
      title: 'Rap',
      id: 5
    }, {
      title: 'Motel',
      id: 6
    }
  ];
}).controller('PlaylistCtrl', function($scope, $stateParams) {});

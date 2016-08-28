'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:TaskIndexCtrl
 * @description
 * # TaskIndexCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
    .controller('TaskIndexCtrl', function ($scope, $uibModal, $routeParams, Task, Mission) {
      $scope.mission = Mission.get({id: $routeParams.mission_id, user_id: $routeParams.user_id });

      $scope.showTask = function (task) {
        $scope.task = task;
        var modalInstance = $uibModal.open({
          animation: false,
          component: 'taskModal',
          resolve: {
            task: function () {
              return $scope.task;
            }
          }
        });

        modalInstance.result.then(function (resp) {
          console.log('aqui');
          var task = resp;
          task.completed = true;
          task = new Task(task);
          var promise = task.$update({mission_id: resp.mission_id, id: resp.id});
          // console.log(promise);
          // console.log(resp);
        }, function () {
          console.log('ali');
        });
      }

    });

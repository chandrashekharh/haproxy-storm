// Generated by CoffeeScript 1.9.3
var HAProxyRegistry, HAProxyService;

HAProxyService = require('./haproxy-service');

HAProxyRegistry = require('./haproxy-registry');

this.include = function() {
  var agent, plugindir, registry;
  agent = this.settings.agent;
  if (agent == null) {
    throw new Error("this plugin requires to be running in the context of a valid StormAgent!");
  }
  plugindir = this.settings.plugindir;
  if (plugindir == null) {
    plugindir = "/var/stormflash/plugins/HAProxy";
  }
  registry = new HAProxyRegistry(plugindir + "/HAProxy.db");
  registry.on('ready', function() {
    var i, len, ref, results1, service;
    ref = this.list();
    results1 = [];
    for (i = 0, len = ref.length; i < len; i++) {
      service = ref[i];
      if (!(service instanceof HAProxyService)) {
        continue;
      }
      agent.log("restore: trying to recover:", service);
      results1.push((function(service) {
        return service.generate(function(err) {
          if (err != null) {
            return agent.log("restore: HAProxy " + service.id + " failed to generate configs!");
          }
        });
      })(service));
    }
    return results1;
  });
  this.post({
    '/HAProxy': function() {
      var err, service;
      try {
        service = new HAProxyService(null, this.body, {});
      } catch (_error) {
        err = _error;
        return this.next(err);
      }
      return service.generate((function(_this) {
        return function(err, results) {
          if (err != null) {
            return _this.next(err);
          }
          agent.log("POST /HAProxy generation results " + JSON.stringify(results));
          registry.add(service);
          return agent.invoke(service, function(err, instance) {
            if (err != null) {
              return _this.next(err);
            } else {
              return _this.send({
                id: service.id,
                running: true
              });
            }
          });
        };
      })(this));
    }
  });
  this.put({
    '/HAProxy/:id': function() {
      var service;
      service = registry.get(this.params.id);
      if (service == null) {
        return this.send(404);
      } else {
        return service.update(this.body, (function(_this) {
          return function(result) {
            return _this.send(result);
          };
        })(this));
      }
    }
  });
  this.get({
    '/HAProxy': function() {
      return this.send(registry.list());
    }
  });
  this.get({
    '/HAProxy/:id': function() {
      var service;
      service = registry.get(this.params.id);
      if (service == null) {
        return this.send(404);
      } else {
        return this.send(service);
      }
    }
  });
  return this.del({
    '/HAProxy/:id': function() {
      var service;
      service = registry.get(this.params.id);
      if (service == null) {
        return this.send(404);
      }
      registry.remove(this.params.id);
      return this.send(204);
    }
  });
};

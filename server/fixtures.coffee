###
# Fixture - we always want a record
###
Packages = ReactionCore.Collections.Packages

Meteor.startup ->
  # set browser policy
  BrowserPolicy.content.allowOriginForAll("www.google-analytics.com")

  # fixtures
  prop = Meteor.settings?.googleAnalyticsProperty
  return unless prop

  # XXX can we load stuff from Meteor.settings in core, perhaps by using a defined syntax such as
  # Meteor.settings.pkgName = config
  # Also, can `property` be merged with `settings`?
  Packages.update {name:"reaction-google-analytics", property: null},
    {$set: {property: prop}},
    (error, result) ->
      if result > 0
        ReactionCore.Events.info "Added google analytics fixture data:", prop

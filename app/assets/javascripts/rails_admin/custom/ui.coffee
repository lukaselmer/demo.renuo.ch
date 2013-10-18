# no asset pipelin in here

$(document).ready ->
  $(document).on 'mousedown', '.save-action', (e) -> # triggers also when submitting form with enter
    for instance of CKEDITOR.instances
      editor = CKEDITOR.instances[instance]
      if editor.checkDirty()
        editor.updateElement();
    return true;


class @RailsAdmin
@RailsAdmin.I18n = class Locale
  @init: (@locale)->
  @t:(key) ->
    humanize = key.charAt(0).toUpperCase() + key.replace("_", " ").slice(1)
    @locale[key] || humanize
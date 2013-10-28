dialog = null
_getModal = ->
  if (!dialog)
    dialog = $('<div id="modal" class="modal modal-wide fade">
                <div class="modal-header">
                  <a href="#" class="close" data-dismiss="modal">&times;</a>
                  <h3 class="modal-header-title">...</h3>
                </div>
                <div class="modal-body">
                  ...
                </div>
                <div class="modal-footer">
                  <a href="#" class="btn cancel-action">...</a>
                  <a href="#" class="btn btn-primary save-action">...</a>
                </div>
              </div>')
      .modal
          keyboard: true,
          backdrop: true,
          show: true
      .on 'hidden', ->
        dialog.remove()
        dialog = null

  return dialog

_bindFormEvents= ->
  dialog = _getModal()
  form = dialog.find("form")
  saveButtonText = dialog.find(":submit[name=_save]").html()
  cancelButtonText = dialog.find(":submit[name=_continue]").html()
  dialog.find('.form-actions').remove()

  form.attr("data-remote", true)
  dialog.find('.modal-header-title').text(form.data('title'))
  dialog.find('.cancel-action').unbind().click( ->
    dialog.modal('hide')
    return false
  ).html(cancelButtonText);

  dialog.find('.save-action').unbind().click( ->
    form.submit()
    return false
  ).html(saveButtonText)

  $('form [data-richtext=ckeditor]').not('.ckeditored').each ->
    window.CKEDITOR_BASEPATH = '/assets/ckeditor/'
    options = $(this).data('options')
    if not window.CKEDITOR
      $(window.document.body).append('<script src="' + options['jspath'] + '"><\/script>')
    if instance = window.CKEDITOR.instances[this.id]
      instance.destroy(true)
    window.CKEDITOR.replace(this, options['options'])
    $(this).addClass('ckeditored')

  form.bind "ajax:complete", (xhr, data, status) ->
    if (status == 'error')
      dialog.find('.modal-body').html(data.responseText)
      _bindFormEvents()
    else
      dialog.modal('hide')
      window.location.reload()



$(document).on 'click', '.content-type.rich-text>.cms-action.edit', (e) ->
  e.preventDefault;

  url = this.href

  if($("#modal").length)
    return false

  dialog = _getModal()

  setTimeout ->
    $.ajax
      url: url,
      beforeSend: (xhr) ->
        xhr.setRequestHeader("Accept", "text/javascript")

      success: (data, status, xhr) ->
        dialog.find('.modal-body').html(data)
        _bindFormEvents()

      error: (xhr, status, error) ->
        dialog.find('.modal-body').html(xhr.responseText)

      dataType: 'text'
  , 200

  return false;


$(document).on 'mousedown', '#modal .save-action', (e) -> # triggers also when submitting form with enter
  for instance of CKEDITOR.instances
    editor = CKEDITOR.instances[instance]
    if editor.checkDirty()
      editor.updateElement();
  return true;
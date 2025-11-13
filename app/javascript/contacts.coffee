document.addEventListener 'DOMContentLoaded', ->
  console.log 'contacts.coffee loaded ✅'
  document.querySelectorAll('.preview-btn').forEach (btn) ->
    btn.addEventListener 'click', ->
      contactId = btn.dataset.contactId
      parent = btn.closest('.contact-card')
      select = parent.querySelector('.template-select')
      templateId = select.value
      unless templateId
        alert 'Please pick a template'
        return

      url = "/contacts/#{contactId}/preview_template?template_id=#{templateId}"
      fetch(url)
        .then (r) ->
          unless r.ok then throw new Error("Preview failed")
          r.json()
        .then (json) ->
          preview = document.getElementById("preview-#{contactId}")
          preview.innerHTML = "<strong>Subject:</strong> #{json.subject}<br/><div style='white-space:pre-wrap;margin-top:8px;'>#{json.body}</div>"
        .catch (err) ->
          alert 'Could not load preview'

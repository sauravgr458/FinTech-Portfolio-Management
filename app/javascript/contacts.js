// app/javascript/contacts.js
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.preview-btn').forEach(btn => {
    btn.addEventListener('click', async () => {
      const contactId = btn.dataset.contactId;
      const parent = btn.closest('.contact-card');
      const select = parent.querySelector('.template-select');
      const templateId = select.value;
      if (!templateId) { alert('Please pick a template'); return; }

      // keep send form in sync
      const sendHidden = parent.querySelector('.send-template-id');
      if (sendHidden) sendHidden.value = templateId;

      try {
        const url = `/contacts/${contactId}/preview_template?template_id=${templateId}`;
        const resp = await fetch(url);
        if (!resp.ok) throw new Error('Preview failed');
        const json = await resp.json();
        const preview = document.getElementById(`preview-${contactId}`);
        preview.innerHTML = `<strong>Subject:</strong> ${escapeHtml(json.subject)}<br/><div style="white-space:pre-wrap;margin-top:8px;">${escapeHtml(json.body)}</div>`;
      } catch(err) {
        alert('Could not load preview');
        console.error(err);
      }
    });
  });

  // helper to escape inserted strings (prevent accidental HTML injection)
  function escapeHtml(str) {
    if (!str) return '';
    return str.replace(/[&<>"'`=\/]/g, s => ({
      '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;','/':'&#x2F;','`':'&#x60;','=':'&#x3D;'
    }[s]));
  }
});

if (Translator.BetterBibTeX) {
    tex.remove('isbn');
    tex.remove('publisher');
    tex.remove('address');
    tex.remove('doi');
    tex.remove('month');
    tex.remove('editor');
    tex.remove('series');
  
    if (tex.entrytype === 'inproceedings') {
      tex.remove('pages');
      tex.remove('volume');
      tex.remove('address');
    }
  
    if (zotero.itemType === 'webpage' && zotero.url) {
      tex.add({ name: 'howpublished', bibtex: "{\\url{" + tex.enc_verbatim({value: zotero.url}) + "}}" });
      // Zotero.debug(tex)
    }
  
    if(tex.has.booktitle && ['NIPS','CVPR','ECCV','AAAI','ICCV','PAMI','BMVC','ICML','SPSYMP','SIGKD','ICLRW','IJCV','IJCNN','ICIP','ICLR', 'WACV'].includes(tex.has.booktitle.value))  {
      tex.has.booktitle.bibtex = tex.has.booktitle.value
      // Zotero.debug(tex.has.booktitle)
    }
  
    if(tex.has.journal && tex.has.journal.value.startsWith('arXiv'))  {
      tex.add({ name: 'journal', value: tex.has.journal.value.replace(/\s*\[.*]\s*/i, '')});
      // Zotero.debug(tex.has.journal)
    }
  }
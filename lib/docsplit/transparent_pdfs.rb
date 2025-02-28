module Docsplit

  # Include a method to transparently convert non-PDF arguments to temporary
  # PDFs. Allows us to pretend to natively support docs, rtf, ppt, and so on.
  module TransparentPDFs

    # Temporarily convert any non-PDF documents to PDFs before running them
    # through further extraction.
    def ensure_pdfs(docs)
      [docs].flatten.map do |doc|
        ext = File.extname(doc)
        if ext.downcase == '.pdf'
          doc
        else
          tempdir = File.dirname(doc) # Put the temp pdf doc in the same directory
          extract_pdf([doc], {:output => tempdir})
          File.join(tempdir, File.basename(doc, ext) + '.pdf')
        end
      end
    end

  end

  extend TransparentPDFs

end


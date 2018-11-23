# frozen_string_literal: true
module TrixHelper
  def change_a_target(body)
    doc = Nokogiri::HTML(body)
    doc.css('a').each do |link|
      link['target'] = '_blank'
      link['rel'] = 'noopener'
    end
    doc.to_s
  end

  def sanitize_trix_html(html)
    sanitize(change_a_target(html), tags: %w(strong em a br ul ol li del h1 pre div),
                                    attributes: %w(id class href target rel))
  end
end

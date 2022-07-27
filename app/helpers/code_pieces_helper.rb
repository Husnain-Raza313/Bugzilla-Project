# frozen_string_literal: true

module CodePiecesHelper
  def screenshot_view(bug)
    if bug.screenshot.url.nil?
      ' (Screenshot Not Available) '
    else
      image_tag(bug.screenshot.url, size: '500x250', alt: 'Screenshot Image')
    end
  end

  def screenshot_field(bug)
        image_tag(bug.screenshot.url, size: '500x250', alt: 'Screenshot Image') unless bug.screenshot.url.nil?
  end

  def deadline_field(bug)
    bug.deadline.nil? ? '(Not Available)' : bug.deadline
  end

  def description_field(bug)
    bug.description == '' ? '(Not Available)' : bug.description
  end
end

prawn_document do |pdf|
  pdf.font Rails.root.join('app/assets/fonts/arial.ttf')
  pdf.image Rails.root.join('app/assets/images/scout_cross.png'), width: 50
  pdf.image Rails.root.join('app/assets/images/scout_lily.png'), width: 50
  pdf.move_down 20
  pdf.stroke do
    pdf.vertical_line 770, 650, at: 65
  end
  pdf.bounding_box([100, 750], width: 350, height: 150) do
    pdf.text t(:zhr)
    pdf.move_down 20
    pdf.text @committee.name
    pdf.move_down 20
    pdf.text @trial.title
  end
  pdf.text t(:info)
  pdf.move_down 20
  pdf.text t(:deadline_colon) + ' ' + l(@trial.deadline, format: :month_year)
  pdf.move_down 5
  pdf.text t(:rank_colon) + ' ' + @trial.rank.name
  pdf.move_down 5
  pdf.text t(:email) + ' ' + @trial.email
  pdf.move_down 5
  pdf.text t(:phone_number) + ' ' + @trial.phone_number
  pdf.move_down 5
  pdf.text t(:created_at) + ' ' + l(@trial.created_at, format: :long)
  pdf.move_down 5
  pdf.text t(:supervisor) + ' ' + @trial.supervisor
  pdf.move_down 5
  pdf.text t(:environment_colon) + ' ' + @trial.environment.name
  pdf.move_down 5



  pdf.move_down 20
  pdf.text t(:tasks)
  pdf.move_down 20

  if @tasks.any?
    pdf.table @tasks.map { |p| ["#{p.number}.", p.content, l(p.deadline, format: :month_year)] }
  else
    pdf.text t(:no_tasks_yet)
  end

  pdf.text_box t(:generated_at) + ' ' + Time.zone.now.to_s, size: 8, align: :right, at: [0, 8]
end

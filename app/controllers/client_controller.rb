class ClientController < ApplicationController
  def index
   # @clients = Client.all  # FIXED: Changed from `client.all` to `Client.all`
    @dob = get_user_dob
    @points = calculate_points
  end

  def widthdraw  # FIXED: Changed from `diposit` to `deposit`
  end

  def show
  end

  private

  def get_user_dob
    dob_file = Rails.root.join('user_dob.txt')

    if File.exist?(dob_file)
      dob = File.read(dob_file).strip
    else
      start_date = Date.today - (60 * 365)
      end_date = Date.today - (18 * 365)
      dob = Date.new(rand(start_date.year..end_date.year), rand(1..12), rand(1..28)).to_s
      File.write(dob_file, dob)
    end

    dob
  end

  def calculate_points
    points_file = Rails.root.join('user_points.txt')

    if File.exist?(points_file)
      data = File.read(points_file).split(",")
      last_login = Date.parse(data[0])
      current_points = data[1].to_i
    else
      last_login = Date.today
      current_points = 0
      File.write(points_file, "#{last_login},#{current_points}")
    end

    days_diff = (Date.today - last_login).to_i

    if days_diff > 0
      total_points = current_points + (days_diff * 1)
      total_points += (total_points * 0.001)
    else
      total_points = current_points
    end

    File.write(points_file, "#{Date.today},#{total_points}")

    total_points.round(2)
  end
end

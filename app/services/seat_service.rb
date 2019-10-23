module SeatService
  module_function

  def get(*args); SeatService::Get.new(*args).call; end
end

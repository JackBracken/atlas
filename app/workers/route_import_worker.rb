class RouteImportWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    puts "================ PERFORMING SIDEKIQ JOB #{args.inspect} ==="
  end
end

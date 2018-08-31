module Bot
  class RespondWorker
    include Sidekiq::Worker
    include Import["user_repo"]

    def perform(args)
      Interactors::Bot::Respond.new.call(
        user: user(args['user_id']),
        template: template(args['template_name']).new
      )
    end

    def user(id)
      user_repo.find_by(id: id)
    end

    def template(template_name)
      Object.const_get "Templates::#{template_name}"
    end
  end
end

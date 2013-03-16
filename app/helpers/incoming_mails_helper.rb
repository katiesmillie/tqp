module IncomingMailsHelper

def get_round(subject)
    @round=Round.where(:id => subject[/\d+/])
end


end



require 'spec_helper'

module VotingApp
  describe 'Voting a submission' do
    let(:user1) { User.create }
    let(:user2) { User.create }
    let(:user3) { User.create }
    let(:submission) { Submission.create description: 'foo' }

    context 'A submission about to be accepted' do
      before do
        Engine.config.votes_limit = 3
        submission.liked_by user1
        submission.liked_by user2
      end

      it 'should be accepted when reach the specified limit of votes' do
        expect do
          submission.liked_by user3
        end.to change{ submission.state }.from('submitted').to('accepted')
      end
    end
  end
end

# frozen_string_literal: true
require 'spec_helper'

describe List do
  describe '#outstanding_tasks' do
    let!(:list) { create(:list) }
    let!(:task1) { create(:task, list: list, completed: false) }
    let!(:task2) { create(:task, list: list, completed: false) }
    let!(:task3) { create(:task, list: list, completed: true) }

    subject { list.outstanding_tasks }

    it 'return the tasks that are not completed' do
      expect(subject).to match_array([task1, task2])
    end
  end

  describe '#add_task' do
    let!(:list) { create(:list) }
    let!(:user) { create(:user) }

    it 'creates the task' do
      expect {
        list.add_task('Buy groceries', user)
      }.to change(Task, :count).by(1)

      expect(Task.last.name).to eq('Buy groceries')
      expect(Task.last.list_id).to eq(list.id)
    end

    it 'updates the list metadata' do
      expect { list.add_task('Buy groceries', user) }.to change(list, :task_count).by(1)
      expect(list.reload.last_added_task).to eq('Buy groceries')
    end
  end
end
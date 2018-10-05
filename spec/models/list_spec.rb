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
end

__END__

query = %(
  SELECT lists.name, count(tasks.id) from lists
  LEFT JOIN tasks on lists.id = tasks.list_id
  group by (lists.id)
)

query = %(
  SELECT lists.name, lists.id as list_id, count(tasks.id) from lists
  LEFT JOIN tasks on lists.id = tasks.list_id
  group by (lists.id)
)

DB[query].to_a
require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= class_name %>, type: :model do
  it 'has a valid factory' do
    expect(create(:<%= table_name.singularize %>)).to be_valid
  end
end
<% end -%>

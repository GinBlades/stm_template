require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= controller_class_name %>Controller, :type => :controller do

  <% single_table = table_name.singularize %>
  describe "Standard CRUD" do
    let(:instance_<%= single_table %>) { assigns(:<%= single_table %>) }
    let(:base_<%= single_table %>) { create(:<%= single_table %>) }
    let(:static_<%= single_table %>) { create(:<%= single_table %>, name: 'spec-<%= single_table %>') }
    let(:valid_attributes) { attributes_for(:<%= single_table %>, name: 'spec-<%= single_table %>') }
    let(:invalid_attributes) { attributes_for(:<%= single_table %>, name: nil) }
  <% unless options[:singleton] -%>
  describe "GET #index" do
      it "populates an array of all @<%= table_name.pluralize %>" do
        second_<%= single_table %> = create :<%= single_table %>
        get :index
        expect(assigns(:<%= table_name %>)).to match_array([base_<%= single_table %>, second_<%= single_table %>])
      end
    end
  <% end -%>
  describe "GET show" do
      it "assigns the requested <%= single_table %> as @<%= single_table %>" do
        get :show, id: base_<%= single_table %>
        expect(instance_<%= single_table %>).to eq(base_<%= single_table %>)
      end
    end
    describe "GET new" do
      it "assigns a new <%= single_table %> as @<%= single_table %>" do
        get :new
        expect(instance_<%= single_table %>).to be_a_new(<%= class_name %>)
      end
    end
    describe "GET edit" do
      it "assigns the requested <%= single_table %> as @<%= single_table %>" do
        get :edit, id: base_<%= single_table %>
        expect(instance_<%= single_table %>).to eq(base_<%= single_table %>)
      end
    end
    describe "POST create" do
      describe "with valid params" do
        it "creates a new <%= class_name %>" do
          expect {
            post :create, <%= single_table %>: attributes_for(:<%= single_table %>)
          }.to change(<%= class_name %>, :count).by(1)
        end

        it "assigns a newly created <%= single_table %> as @<%= single_table %>" do
          post :create, <%= single_table %>: attributes_for(:<%= single_table %>)
          expect(instance_<%= single_table %>).to be_a(<%= class_name %>)
          expect(instance_<%= single_table %>).to be_persisted
        end

        it "redirects to the created <%= single_table %>" do
          post :create, <%= single_table %>: attributes_for(:<%= single_table %>)
          expect(response).to redirect_to(<%= class_name %>.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved <%= single_table %> as @<%= single_table %>" do
          post :create, <%= single_table %>: invalid_attributes
          expect(instance_<%= single_table %>).to be_a_new(<%= class_name %>)
        end

        it "re-renders the 'new' template" do
          post :create, <%= single_table %>: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "assigns the requested <%= single_table %> as @<%= single_table %>" do
          put :update, id: static_<%= single_table %>, <%= single_table %>: valid_attributes
          static_<%= single_table %>.reload
          expect(instance_<%= single_table %>).to eq(static_<%= single_table %>)
        end

        it "redirects to the <%= single_table %>" do
          put :update, id: static_<%= single_table %>, <%= single_table %>: valid_attributes
          expect(response).to redirect_to(static_<%= single_table %>)
        end
      end

      describe "with invalid params" do
        it "assigns the <%= single_table %> as @<%= single_table %>" do
          put :update, id: static_<%= single_table %>, <%= single_table %>: invalid_attributes
          expect(assigns(:<%= single_table %>)).to eq(static_<%= single_table %>)
        end

        it "re-renders the 'edit' template" do
          put :update, id: static_<%= single_table %>, <%= single_table %>: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested <%= single_table %>" do
        new_<%= single_table %> = create :<%= single_table %>
        expect {
          delete :destroy, id: new_<%= single_table %>
        }.to change(<%= class_name %>, :count).by(-1)
      end

      it "redirects to the <%= single_table %> list" do
        delete :destroy, id: base_<%= single_table %>
        expect(response).to redirect_to(<%= table_name.pluralize %>_url)
      end
    end

  end
end
<% end -%>

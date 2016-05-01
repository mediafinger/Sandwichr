require "rails_helper"

describe Api::SandwichesController do
  let!(:blt_sandwich)  { Sandwich.create!(name: "BLT", bread_type: "rye") }
  let!(:tuna_sandwich) { Sandwich.create!(name: "Tuna", bread_type: "rye") }

  let(:invalid_id) { 999999 }
  let(:sandwich) {
    sandwich = {}
    sandwich[:name] = new_name
    sandwich
  }

  # GET index
  #
  describe "#index" do
    before { get :index, format: :json }

    it "renders json with code 200" do
      expect(response.content_type).to eq "application/json"
      expect(response.code).to eq "200"
    end

    it "renders all sandwiches" do
      expect(response.body).to include blt_sandwich.name
      expect(response.body).to include tuna_sandwich.name
    end
  end

  # GET show
  #
  describe "#show" do
    context "with an existing id" do
      before { get :show, id: 1, format: :json }

      it "renders json with code 200" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "200"
      end

      it "renders the sandwich" do
        expect(response.body).to include blt_sandwich.name
        expect(response.body).to include blt_sandwich.bread_type
      end
    end

    context "with a non-existing id" do
      before { get :show, id: invalid_id, format: :json }

      it "renders json with code 404" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "404"
      end

      it "renders an error message" do
        expect(response.body).to include "Sandwich with id #{invalid_id} not found"
      end
    end
  end

  # POST create
  #
  describe "#create" do
    context "with valid data" do
      let(:new_name) { "BACON" }
      before { post :create, sandwich: sandwich, format: :json }

      it "renders json with code 201" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "201"
      end

      it "renders the sandwich" do
        expect(response.body).to include "BACON"
      end

      it "saves the Sandwich to the database" do
        expect(Sandwich.count).to eql 3
      end
    end

    context "with invalid data" do
      let(:new_name) { "1" }
      before { post :create, sandwich: sandwich, format: :json }

      it "renders json with code 422" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "422"
      end

      it "renders an error message" do
        expect(response.body).to include "Name is too short"
      end

      it "does not save the Sandwich to the database" do
        expect(Sandwich.count).to eql 2
      end
    end

    context "with a non-existing id" do
      before { put :update, id: invalid_id, name: "BACON", format: :json }

      it "renders json with code 404" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "404"
      end

      it "renders an error message" do
        expect(response.body).to include "Sandwich with id #{invalid_id} not found"
      end

      it "does not save the Sandwich to the database" do
        expect(Sandwich.count).to eql 2
      end
    end
  end

  # PUT / PATCH update
  #
  describe "#update" do
    context "with an existing id and valid data" do
      let(:new_name) { "BACON" }
      before { put :update, id: 1, sandwich: sandwich, format: :json }

      it "renders json with code 200" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "200"
      end

      it "renders the sandwich" do
        expect(response.body).to include "BACON"
        expect(response.body).to include blt_sandwich.bread_type
      end

      it "does not save a new Sandwich to the database" do
        expect(Sandwich.count).to eql 2
      end
    end

    context "with an existing id but invalid data" do
      let(:new_name) { "1" }
      before { put :update, id: 1, sandwich: sandwich, format: :json }

      it "renders json with code 422" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "422"
      end

      it "renders an error message" do
        expect(response.body).to include "Name is too short"
      end
    end

    context "with a non-existing id" do
      before { put :update, id: invalid_id, name: "BACON", format: :json }

      it "renders json with code 404" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "404"
      end

      it "renders an error message" do
        expect(response.body).to include "Sandwich with id #{invalid_id} not found"
      end
    end
  end

  # DELETE destroy
  #
  describe "#destroy" do
    context "with an existing id" do
      before { delete :destroy, id: 1, format: :json }

      it "renders json with code 200" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "200"
      end

      it "renders the sandwich" do
        expect(response.body).to include blt_sandwich.name
        expect(response.body).to include blt_sandwich.bread_type
      end

      it "deletes the Sandwich from the database" do
        expect(Sandwich.count).to eql 1
      end
    end

    context "with a non-existing id" do
      before { put :update, id: invalid_id, name: "BACON", format: :json }

      it "renders json with code 404" do
        expect(response.content_type).to eq "application/json"
        expect(response.code).to eq "404"
      end

      it "renders an error message" do
        expect(response.body).to include "Sandwich with id #{invalid_id} not found"
      end

      it "does not delete a random Sandwich from the database" do
        expect(Sandwich.count).to eql 2
      end
    end
  end
end

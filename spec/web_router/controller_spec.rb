require 'spec_helper'

RSpec.describe WebRouter::Controller do
  let(:controller) do
    Class.new(described_class) do
      def test_action
        response(:text, 'simple test')
      end

      def text_action
        response(:text, params.inspect)
      end

      def json_action
        response(:json, params)
      end

      def html_action
        response(:html, '<h1>test</h1>')
      end

      def html_with_erb_action
        @message = params['message']
        response(:html, erb(:'spec/fixtures/views/index.html.erb'))
      end
    end
  end

  describe '#action' do
    it 'returns proc' do
      expect(controller.action(:test)).to be_a(Proc)
    end

    it 'generated proc calls action' do
      expect(controller.action(:test_action).call(Rack::MockRequest.env_for('/')))
        .to eq([200, { 'Content-Type' => 'text/plain' }, ['simple test']])
    end
  end

  describe 'request processing' do
    subject do
      controller
        .action(action)
        .call(Rack::MockRequest.env_for('/?a=b&e=r').merge!(router_params))
    end

    let(:router_params) { {} }

    context 'when text response' do
      context 'response with simple text' do
        let(:action) { :test_action }

        it 'successfully responds' do
          expect(subject)
            .to eq([200, {'Content-Type'=>'text/plain'}, ['simple test']])
        end
      end

      context 'response with params' do
        let(:action) { :text_action }

        it 'successfully responds' do
          expect(subject)
            .to eq([200, {"Content-Type"=>"text/plain"}, ["{\"a\"=>\"b\", \"e\"=>\"r\"}"]])
        end
      end
      let(:action) { :test_action }

      it 'successfully responds' do
        expect(subject)
          .to eq([200, {"Content-Type"=>"text/plain"}, ["simple test"]])
      end
    end

    context 'when json response' do
      let(:action) { :json_action }

      it 'successfully responds' do
        expect(subject)
          .to eq([200, {"Content-Type"=>"application/json"}, ["{\"a\":\"b\",\"e\":\"r\"}"]])
      end
    end

    context 'when html response' do
      let(:action) { :html_action }

      it 'successfully responds' do
        expect(subject)
          .to eq([
            200,
            {"Content-Type"=>"text/html"},
            ["<h1>test</h1>"]
          ])
      end
    end

    context 'when html response with erb' do
      let(:action) { :html_with_erb_action }
      let(:router_params) { { 'router.params' => { 'message' => 'Hello world!' } } }

      it 'successfully responds' do
        expect(subject)
          .to eq([
            200,
            { 'Content-Type' => 'text/html' },
            ['<h1>Hello world!</h1>']
          ])
      end
    end

    context 'when has router params' do
      let(:router_params) { { 'router.params' => { 'param' => 'value' } } }
      let(:action) { :json_action }

      it 'successfully responds' do
        expect(subject)
          .to eq([
            200,
            {"Content-Type"=>"application/json"},
            ["{\"a\":\"b\",\"e\":\"r\",\"param\":\"value\"}"]]
           )
      end
    end
  end
end

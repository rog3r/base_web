module FactoryGirl
  module Strategy
    class FindByFactory
      def association(runner)
        runner.run
      end

      def result(evaluation)
        build_class(evaluation).where(get_overrides(evaluation)).first
      end

      private

      def build_class(evaluation)
        evaluation.instance_variable_get(:@attribute_assigner).instance_variable_get(:@build_class)
      end

      def get_overrides(evaluation = nil)
        return @overrides unless @overrides.nil?
        evaluation.instance_variable_get(:@attribute_assigner).instance_variable_get(:@evaluator).instance_variable_get(:@overrides).clone
      end
    end

    class FindOrCreate
      def initialize
        @strategy = FactoryGirl.strategy_by_name(:find_by_factory).new
      end

      delegate :association, to: :@strategy

      def result(evaluation)
        found_object = @strategy.result(evaluation)

        if found_object.nil?
          @strategy = FactoryGirl.strategy_by_name(:create).new
          @strategy.result(evaluation)
        else
          found_object
        end
      end
    end
  end

  FactoryGirl.register_strategy(:find_by_factory, Strategy::FindByFactory)
  FactoryGirl.register_strategy(:find_or_create, Strategy::FindOrCreate)

end
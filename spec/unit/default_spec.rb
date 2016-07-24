describe 'RainbowWrapper First level' do
  describe 'Second level' do
    context 'Third level' do
      it 'Prints test output in default color' do
        RSpecLog.add_to_log 'Name1', 'some test code'
      end
      it 'Second test' do
        RSpecLog.add_to_log 'Name2', 'some test code'
      end
      it 'Third test' do
        RSpecLog.add_to_log 'Name3', 'some test code'
      end
    end
  end
end

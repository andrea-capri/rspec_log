describe 'RainbowWrapper First level' do
  describe 'Second level' do
    context 'Third level' do
      it 'prints test output in default color' do
        RSpecLog.add_to_log 'Defaults2 Name1', 'some test code'
      end
      it 'a test!!' do
        RSpecLog.add_to_log 'Defaults2 Name2', 'some test code'
      end
    end
  end
end

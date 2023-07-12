class Player {
    private var _name:String;
    private var _mark:String;

    public function new(_name:String, _mark:String) {
        this._name = _name;
        this._mark = _mark;
    }

    public function name():String {
        return this._name;
    }

    public function mark():String {
        return this._mark;
    }
}
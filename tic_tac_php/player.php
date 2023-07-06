<?php

class Player {
    private string $name;
    private string $mark;

    public function __construct($name, $mark) {
        $this->name = $name;
        $this->mark = $mark;
    }

    public function __get($name) {
        return $this->$name;
    }
}
?>
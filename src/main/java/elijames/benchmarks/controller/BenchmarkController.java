package elijames.benchmarks.controller;

import elijames.benchmarks.test.RequestTest;
import elijames.benchmarks.test.ResponseTest;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BenchmarkController {

    @PostMapping("/request-test")
    public ResponseTest test(@RequestBody RequestTest test) {
        return new ResponseTest("value-response-test. Input: " + test.getInput());
    }
}

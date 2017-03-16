package main.doge

import spock.lang.Specification

class FirstPipelineSpec extends Specification {

    @Delegate PipelineTestHelper pipelineTestHelper = new PipelineTestHelper()

    def setup() {
        pipelineTestHelper.setUp()
    }

    def 'does something'() {
        def invocations = []

        given:
        def shellMock = Mock(Closure)
        shellMock.call(_) >> { args ->
            invocations << args
        }

        helper.registerAllowedMethod('sh', [String], shellMock)

        when:
        def script = loadScript('../Jenkinsfile')
        script.execute()

        then:
        assert invocations == []

    }
}

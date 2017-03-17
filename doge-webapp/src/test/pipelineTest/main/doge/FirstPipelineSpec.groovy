package main.doge

import spock.lang.Specification

import static com.lesfurets.jenkins.unit.MethodCall.callArgsToString

class FirstPipelineSpec extends Specification {

    @Delegate PipelineTestHelper pipelineTestHelper = new PipelineTestHelper()

    def setup() {
        pipelineTestHelper.setUp()
    }

    def 'should determine first sh call in jenkinsfile'() {
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
        assert invocations.first() == ['./gradlew test']

    }

    def 'should call gradlew test in the jenkinsfile'() {
        given:

        when:
        loadScript('../Jenkinsfile')

        then:
        callArgsToString(helper.callStack.findAll { call ->
            call.methodName == 'sh'
        }.first()) == './gradlew test'
    }
}

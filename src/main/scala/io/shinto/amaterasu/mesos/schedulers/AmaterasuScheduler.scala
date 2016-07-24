package io.shinto.amaterasu.mesos.schedulers

import io.shinto.amaterasu.Logging
import org.apache.mesos.Protos.{ Value, Resource }
import org.apache.mesos.Scheduler

trait AmaterasuScheduler extends Scheduler with Logging {

  def createScalarResource(name: String, value: Double): Resource = {
    Resource.newBuilder
      .setName(name)
      .setType(Value.Type.SCALAR)
      .setScalar(Value.Scalar.newBuilder().setValue(value)).build()
  }

}
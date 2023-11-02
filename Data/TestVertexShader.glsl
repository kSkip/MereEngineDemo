#version 410

#extension GL_EXT_gpu_shader4 : enable

uniform sampler2D tex;

uniform mat4 MV, P, translation, rotation;
uniform bool skipMVP, skipLighting;

layout(location = 0) in vec3 position;
layout(location = 1) in vec3 normal;
layout(location = 2) in vec2 texcoord;

layout(location = 3) out vec3 fragPosition;
layout(location = 4) out vec3 fragNormal;
layout(location = 5) out vec2 fragTexcoord;

void main(){
	
	vec4 transformedposition;
	vec4 transformednormal;

	transformednormal = rotation * vec4(normal,0.0);
	transformedposition = translation * rotation * vec4(position,1.0);

	if(!skipMVP){

		gl_Position = P * MV * transformedposition;
		transformednormal = MV * transformednormal;

	}else{

		gl_Position = transformedposition;

	}

	fragPosition = transformedposition.xyz;
	fragNormal = transformednormal.xyz;
	fragTexcoord = texcoord;

}

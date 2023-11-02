#version 410

uniform sampler2D tex;
uniform mat4 MV, P;

uniform bool skipMVP, skipLighting;

layout(location = 3) in vec3 fragPosition;
layout(location = 4) in vec3 fragNormal;
layout(location = 5) in vec2 fragTexcoord;

out vec4 fragColor;

const vec4 lightDiffuse = vec4(0.3, 0.3, 0.3, 0.0);
const vec4 lightAmbient = vec4(0.3, 0.3, 0.3, 1.0);
const vec4 lightSpecular = vec4(0.0, 0.0, 0.0, 0.0);

void main(){	

	vec3 lightDirection = -vec3(1.0,1.0,1.0);

	if(!skipLighting){

		vec3 mvLightDirection = normalize((MV * vec4(lightDirection, 0.0)).xyz);
		vec3 normal = normalize(fragNormal);
		vec3 eye = normalize(fragPosition);
		vec3 reflection = reflect(mvLightDirection, normal);

		vec4 fragDiffuse = texture2D(tex, fragTexcoord);

		vec4 diffuseFactor = max(dot(normal, mvLightDirection), 0.0) * lightDiffuse;

		vec4 ambientDiffuseFactor = diffuseFactor + lightAmbient;


		fragColor = ambientDiffuseFactor * fragDiffuse;

	}else{

		fragColor = texture2D(tex, fragTexcoord);

	}

}

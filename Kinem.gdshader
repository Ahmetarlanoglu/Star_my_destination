shader_type canvas_item;
uniform bool pass;
uniform sampler2D emission_teture;
uniform vec4 glow_color : hint_color = vec4(1.0);
uniform int radius=5;
uniform vec3 offset=vec3(0.0);
void fragment()
{
	vec4 current_color = texture(TEXTURE,UV); // what's our current sprite pixel
	vec4 emission_color = texture(emission_teture,UV); // what's our current emission pixel
		if(pass==true){
		if(emission_color.r > 0f ) // check if we're not black in the emission color.
		{
			//COLOR = (((current_color+emission_color/2f))+ glow_color/2f) // add brightness corrosponding with the emission pixel
			
			COLOR = (current_color+ glow_color) ;
		
		}
		else
		{
			COLOR = current_color; // we arent over an emission pixel leave alone
		}
	}
	else{
		COLOR = current_color; // we arent over an emission pixel leave alone
		vec2 src_size = vec2 ( SCREEN_PIXEL_SIZE.x,  SCREEN_PIXEL_SIZE.y);
     vec2 uv = UV.xy;
     float n = float((radius + 1) * (radius + 1));
     vec3 m0 = offset; vec3 m1 = offset; vec3 m2 = offset; vec3 m3 = offset;
     vec3 s0 = offset; vec3 s1 = offset; vec3 s2 = offset; vec3 s3 = offset;
     vec3 c;
	vec4 hafiza;
	if (current_color.a>0f ){
     for (int j = -radius; j <= 0; ++j)  {
         for (int i = -radius; i <= 0; ++i)  {
             c = texture(TEXTURE, uv + vec2(float(i),float(j)) * src_size).rgb;
             m0 += c;
             s0 += c * c;
         }
     }
     for (int j = -radius; j <= 0; ++j)  {
         for (int i = 0; i <= radius; ++i)  {
             c = texture(TEXTURE, uv + vec2(float(i),float(j)) * src_size).rgb;
             m1 += c;
             s1 += c * c;
         }
     }
     for (int j = 0; j <= radius; ++j)  {
         for (int i = 0; i <= radius; ++i)  {
             c = texture(TEXTURE, uv + vec2(float(i),float(j)) * src_size).rgb;
             m2 += c;
             s2 += c * c;
         }
     }
     for (int j = 0; j <= radius; ++j)  {
         for (int i = -radius; i <= 0; ++i)  {
             c = texture(TEXTURE, uv + vec2(float(i),float(j)) * src_size).rgb;
             m3 += c;
             s3 += c * c;
         }
     }
     float min_sigma2 = 1e+2;
     m0 /= n;
     s0 = abs(s0 / n - m0 * m0);

     float sigma2 = s0.r + s0.g + s0.b;
     if (sigma2 < min_sigma2) {
         min_sigma2 = sigma2;
         COLOR = vec4(m0, 1.0);
		hafiza=texture(TEXTURE,UV);
     }

     m1 /= n;
     s1 = abs(s1 / n - m1 * m1);

     sigma2 = s1.r + s1.g + s1.b;
     if (sigma2 < min_sigma2) {
         min_sigma2 = sigma2;
         COLOR = vec4(m1, 1.0);
		hafiza=texture(TEXTURE,UV);
     }

     m2 /= n;
     s2 = abs(s2 / n - m2 * m2);

     sigma2 = s2.r + s2.g + s2.b;
     if (sigma2 < min_sigma2) {
         min_sigma2 = sigma2;
         COLOR = vec4(m2, 1.0);
		hafiza=texture(TEXTURE,UV);
     }
     m3 /= n;
     s3 = abs(s3 / n - m3 * m3);
     sigma2 = s3.r + s3.g + s3.b;
     if (sigma2 < min_sigma2) {
         min_sigma2 = sigma2;
         COLOR = vec4(m3, 1.0);
		hafiza=texture(TEXTURE,UV);
     }
	}
	else{
		COLOR=current_color;
	}

	}
}
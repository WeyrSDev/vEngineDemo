#pragma once
#include "vDrawableComponent.h"

using namespace vEngine;

namespace vEngine
{
	class Effect;
	class PointLight;
	class Keyboard;
	class ProxyModel;
	class RenderStateHelper;
}

namespace DirectX
{
	class SpriteBatch;
	class SpriteFont;
}

namespace Rendering
{
	class PointLightMaterial;

	class PointLightDemo : public DrawableComponent
	{
		RTTI_DECLARATIONS(PointLightDemo, DrawableComponent)

	public:
		PointLightDemo(Engine& game, Camera& camera);
		~PointLightDemo();

		virtual void Initialize() override;
		virtual void Update(const Time& gameTime) override;
		virtual void Draw(const Time& gameTime) override;

	private:
		PointLightDemo();
		PointLightDemo(const PointLightDemo& rhs);
		PointLightDemo& operator=(const PointLightDemo& rhs);

		void UpdateAmbientLight(const Time& gameTime);
		void UpdatePointLight(const Time& gameTime);
		void UpdateSpecularLight(const Time& gameTime);

		static const float LightModulationRate;
		static const float LightMovementRate;

		Effect* mEffect;
		PointLightMaterial* mMaterial;
		ID3D11ShaderResourceView* mTextureShaderResourceView;
		ID3D11Buffer* mVertexBuffer;
		ID3D11Buffer* mIndexBuffer;
		UINT mIndexCount;

		Keyboard* mKeyboard;
		XMCOLOR mAmbientColor;
		PointLight* mPointLight;
		XMCOLOR mSpecularColor;
		float mSpecularPower;
		XMFLOAT4X4 mWorldMatrix;

		ProxyModel* mProxyModel;

		RenderStateHelper* mRenderStateHelper;
		SpriteBatch* mSpriteBatch;
		SpriteFont* mSpriteFont;
		XMFLOAT2 mTextPosition;
	};
}

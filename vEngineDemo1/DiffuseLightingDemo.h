#pragma once
#include "vDrawableComponent.h"
using namespace vEngine;

namespace vEngine {
	class Effect;
	class DirectionalLight;
	class Keyboard;
	class ProxyModel;
	class RenderStateHelper;
}

namespace DirectX {
	class SpriteBatch;
	class SpriteFont;
}

namespace Rendering {
	class DiffuseLightingMaterial;
	class DiffuseLightingDemo : public DrawableComponent {
		RTTI_DECLARATIONS(DiffuseLightingDemo, DrawableComponent)
	public:
		DiffuseLightingDemo(Engine& game, Camera& camera);
		~DiffuseLightingDemo();
	private:
		DiffuseLightingDemo();
		DiffuseLightingDemo(const DiffuseLightingDemo& rhs);
		DiffuseLightingDemo& operator=(const DiffuseLightingDemo& rhs);
	public:
		virtual void Initialize() override;
		virtual void Update(const Time& gameTime) override;
		virtual void Draw(const Time& gameTime) override;
	private:
		void UpdateAmbientLight(const Time& gameTime);
		void UpdateDirectionalLight(const Time& gameTime);
	private:
		static const float LightModulationRate;
		static const XMFLOAT2 LightRotationRate;
	private:
		Effect* mEffect;
		DiffuseLightingMaterial* mMaterial;
		ID3D11ShaderResourceView* mTextureShaderResourceView;
		ID3D11Buffer* mVertexBuffer;
		ID3D11Buffer* mIndexBuffer;
		UINT mIndexCount;
		XMCOLOR mAmbientColor;
		DirectionalLight* mDirectionalLight;
		Keyboard* mKeyboard;
		XMFLOAT4X4 mWorldMatrix;
		ProxyModel* mProxyModel;
		RenderStateHelper* mRenderStateHelper;
		SpriteBatch* mSpriteBatch;
		SpriteFont* mSpriteFont;
		XMFLOAT2 mTextPosition;
	};
}